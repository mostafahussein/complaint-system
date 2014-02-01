# == Schema Information
#
# Table name: tickets
#
#  id          :integer          not null, primary key
#  title       :string(50)
#  description :text
#  student_id  :integer
#  subject_id  :integer
#  priority_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Ticket < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) {controller && controller.current_user}
  scope :opened   , includes({ticket_statuses: :status}).where('statuses.ticket_status = ? '  , 'Open')
  scope :solved   , includes({ticket_statuses: :status}).where('statuses.ticket_status = ?'   , 'Solved')
  scope :closed   , includes({ticket_statuses: :status}).where('statuses.ticket_status = ?'   , 'Closed')
  scope :overdue  , includes({ticket_statuses: :status}).where('statuses.ticket_status != ? AND due < ?'   , 'Solved', Date.today.to_s)
  scope :today    , includes({ticket_statuses: :status}).where('statuses.ticket_status != ? AND due = ?'   , 'Solved', Date.today.to_s)
  scope :upcoming , includes({ticket_statuses: :status}).where('statuses.ticket_status != ? AND due > ?'   , 'Solved', Date.today.to_s)

  attr_accessible :title, :description, :ticket_state, :assign_state, :due, :created_at , :student_id, :priority_id, :subject_id,
  :ticket_statuses_attributes, :follow_ups_attributes
  belongs_to :priority
  belongs_to :student
  has_many :ticket_statuses
  has_many :statuses , through: :ticket_statuses
  accepts_nested_attributes_for :ticket_statuses
  has_many :follow_ups
  accepts_nested_attributes_for :follow_ups

  def self.total_timeline
    self.find_by_sql("SELECT (EXTRACT(EPOCH FROM date)*1000) AS date, coalesce(count,0) AS count
    FROM generate_series( '2013-01-01 00:00'::timestamp, '2014-12-31 00:00'::timestamp, '1 day') AS date
    LEFT OUTER JOIN (SELECT date_trunc('day', tickets.created_at) as day, count(tickets.id) as count
    FROM tickets
    WHERE created_at >= '2013-01-01 00:00' AND created_at < '2014-12-31 00:00' GROUP BY day ORDER BY day ASC) results
    ON (date = results.day)")
  end

  def self.open_timeline
    self.find_by_sql("SELECT (EXTRACT(EPOCH FROM date)*1000) AS date, coalesce(count,0) AS count
    FROM generate_series( '2013-01-01 00:00'::timestamp, '2014-12-31 00:00'::timestamp, '1 day') AS date
    LEFT OUTER JOIN (SELECT date_trunc('day', tickets.created_at) as day, count(tickets.id) as count
    FROM tickets, ticket_statuses,statuses
    WHERE (tickets.created_at >= '2013-01-01 00:00' AND tickets.created_at < '2014-12-31 00:00') AND
    tickets.id = ticket_statuses.ticket_id AND ticket_statuses.status_id = statuses.id AND statuses.ticket_status = 'Open'     
    GROUP BY day
    ORDER BY day ASC) results ON (date = results.day)")
  end

  def self.in_progress_timeline
    self.find_by_sql("SELECT (EXTRACT(EPOCH FROM date)*1000) AS date, coalesce(count,0) AS count
    FROM generate_series( '2013-01-01 00:00'::timestamp, '2014-12-31 00:00'::timestamp, '1 day') AS date
    LEFT OUTER JOIN (SELECT date_trunc('day', tickets.created_at) as day, count(tickets.id) as count
    FROM tickets, ticket_statuses,statuses
    WHERE (tickets.created_at >= '2013-01-01 00:00' AND tickets.created_at < '2014-12-31 00:00') AND
    tickets.id = ticket_statuses.ticket_id AND ticket_statuses.status_id = statuses.id AND statuses.ticket_status = 'In Progress'     
    GROUP BY day
    ORDER BY day ASC) results ON (date = results.day)")
  end

  def self.pending_timeline
    self.find_by_sql("SELECT (EXTRACT(EPOCH FROM date)*1000) AS date, coalesce(count,0) AS count
    FROM generate_series( '2013-01-01 00:00'::timestamp, '2014-12-31 00:00'::timestamp, '1 day') AS date
    LEFT OUTER JOIN (SELECT date_trunc('day', tickets.created_at) as day, count(tickets.id) as count
    FROM tickets, ticket_statuses,statuses
    WHERE (tickets.created_at >= '2013-01-01 00:00' AND tickets.created_at < '2014-12-31 00:00') AND
    tickets.id = ticket_statuses.ticket_id AND ticket_statuses.status_id = statuses.id AND statuses.ticket_status = 'Pending'     
    GROUP BY day
    ORDER BY day ASC) results ON (date = results.day)")
  end

  def self.solved_timeline
    self.find_by_sql("SELECT (EXTRACT(EPOCH FROM date)*1000) AS date, coalesce(count,0) AS count
    FROM generate_series( '2013-01-01 00:00'::timestamp, '2014-12-31 00:00'::timestamp, '1 day') AS date
    LEFT OUTER JOIN (SELECT date_trunc('day', tickets.created_at) as day, count(tickets.id) as count
    FROM tickets, ticket_statuses,statuses
    WHERE (tickets.created_at >= '2013-01-01 00:00' AND tickets.created_at < '2014-12-31 00:00') AND
    tickets.id = ticket_statuses.ticket_id AND ticket_statuses.status_id = statuses.id AND statuses.ticket_status = 'Solved'     
    GROUP BY day
    ORDER BY day ASC) results ON (date = results.day)")
  end

  def self.closed_timeline
    self.find_by_sql("SELECT (EXTRACT(EPOCH FROM date)*1000) AS date, coalesce(count,0) AS count
    FROM generate_series( '2013-01-01 00:00'::timestamp, '2014-12-31 00:00'::timestamp, '1 day') AS date
    LEFT OUTER JOIN (SELECT date_trunc('day', tickets.created_at) as day, count(tickets.id) as count
    FROM tickets, ticket_statuses,statuses
    WHERE (tickets.created_at >= '2013-01-01 00:00' AND tickets.created_at < '2014-12-31 00:00') AND
    tickets.id = ticket_statuses.ticket_id AND ticket_statuses.status_id = statuses.id AND statuses.ticket_status = 'Closed'     
    GROUP BY day
    ORDER BY day ASC) results ON (date = results.day)")
  end

  def self.high_timeline
    self.find_by_sql("SELECT (EXTRACT(EPOCH FROM date)*1000) AS date, coalesce(count,0) AS count
    FROM generate_series( '2013-01-01 00:00:00'::timestamp, '2014-12-31 00:00:00'::timestamp, '1 day') AS date
    LEFT OUTER JOIN (SELECT date_trunc('day', tickets.created_at) as day, count(tickets.id) as count
    FROM tickets,priorities
    WHERE (tickets.created_at >= '2013-01-01 00:00:00' AND tickets.created_at < '2014-12-31 00:00:00') AND
    priority_id = priorities.id AND priorities.priority_name = 'High'
    GROUP BY day
    ORDER BY day ASC) results ON (date = results.day)")
  end

  def self.normal_timeline
    self.find_by_sql("SELECT (EXTRACT(EPOCH FROM date)*1000) AS date, coalesce(count,0) AS count
    FROM generate_series( '2013-01-01 00:00:00'::timestamp, '2014-12-31 00:00:00'::timestamp, '1 day') AS date
    LEFT OUTER JOIN (SELECT date_trunc('day', tickets.created_at) as day, count(tickets.id) as count
    FROM tickets,priorities
    WHERE (tickets.created_at >= '2013-01-01 00:00:00' AND tickets.created_at < '2014-12-31 00:00:00') AND
    priority_id = priorities.id AND priorities.priority_name = 'Normal'
    GROUP BY day
    ORDER BY day ASC) results ON (date = results.day)")
  end

  def self.low_timeline
    self.find_by_sql("SELECT (EXTRACT(EPOCH FROM date)*1000) AS date, coalesce(count,0) AS count
    FROM generate_series( '2013-01-01 00:00:00'::timestamp, '2014-12-31 00:00:00'::timestamp, '1 day') AS date
    LEFT OUTER JOIN (SELECT date_trunc('day', tickets.created_at) as day, count(tickets.id) as count
    FROM tickets,priorities
    WHERE (tickets.created_at >= '2013-01-01 00:00:00' AND tickets.created_at < '2014-12-31 00:00:00') AND
    priority_id = priorities.id AND priorities.priority_name = 'Low'
    GROUP BY day
    ORDER BY day ASC) results ON (date = results.day)")
  end

  def self.ticket_priority_details
    self.find_by_sql("SELECT COUNT(*) AS total_complaints,
    COUNT(CASE p.priority_name WHEN 'High'        THEN 1 END) AS high_complaints,
    COUNT(CASE p.priority_name WHEN 'Normal' THEN 1 END) AS normal_complaints,
    COUNT(CASE p.priority_name WHEN 'Low'     THEN 1 END) AS low_complaints
    FROM
    tickets AS t
    JOIN
    priorities AS p
    ON t.priority_id = p.id
    WHERE
    p.priority_name IN ('High', 'Normal', 'Low')
    ORDER BY total_complaints ASC")
  end

  def self.subject_priority_details
    self.find_by_sql("SELECT s.subject_title  AS subject_name,
    COUNT(*) AS total_complaints,
    COUNT(CASE p.priority_name WHEN 'High'        THEN 1 END) AS high_complaints,
    COUNT(CASE p.priority_name WHEN 'Normal' THEN 1 END) AS normal_complaints,
    COUNT(CASE p.priority_name WHEN 'Low'     THEN 1 END) AS low_complaints
    FROM
    tickets AS t
    JOIN
    subjects AS s
    ON  t.subject_id = s.id
    JOIN
    priorities AS p
    ON t.priority_id = p.id
    WHERE
    p.priority_name IN ('High', 'Normal', 'Low')
    GROUP BY s.subject_title
    ORDER BY total_complaints ASC")
  end
  
  def self.recent
    self.find_by_sql("SELECT * FROM tickets ORDER BY tickets.created_at DESC LIMIT 20")   
  end

end