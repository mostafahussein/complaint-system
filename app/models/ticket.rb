<<<<<<< HEAD
# == Schema Information
#
# Table name: tickets
#
#  id                    :integer          not null, primary key
#  description           :text
#  student_id            :integer
#  subject_id            :integer
#  priority_id           :integer
#  due                   :date
#  category_id           :integer
#  date_of_alleged_event :date
#  reason_of_delay       :text
#  expectations          :text
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_tickets_on_id  (id)
=======
# ## Schema Information
#
# Table name: `tickets`
#
# ### Columns
#
# Name                         | Type               | Attributes
# ---------------------------- | ------------------ | ---------------------------
# **`id`**                     | `integer`          | `not null, primary key`
# **`description`**            | `text`             |
# **`student_id`**             | `integer`          |
# **`subject_id`**             | `integer`          |
# **`priority_id`**            | `integer`          |
# **`due`**                    | `date`             |
# **`category_id`**            | `integer`          |
# **`date_of_alleged_event`**  | `date`             |
# **`reason_of_delay`**        | `text`             |
# **`expectations`**           | `text`             |
# **`created_at`**             | `datetime`         | `not null`
# **`updated_at`**             | `datetime`         | `not null`
#
# ### Indexes
#
# * `index_tickets_on_id`:
#     * **`id`**
>>>>>>> ccede0020a94bfc95d0b555b99297784cd882d81
#

class Ticket < ActiveRecord::Base
  include PublicActivity::Common
  include Modules::DefaultValues
  # tracked owner: ->(controller, model) {controller && controller.current_user}
  # tracked recipient: ->(controller, model) { model && model.student.user }
  scope :opened   , joins({ticket_statuses: :status}).where('statuses.ticket_status = ? '  , "#{Ticket::OPEN}")
  scope :solved   , joins({ticket_statuses: :status}).where('statuses.ticket_status = ?'   , "#{Ticket::SOLVED}")
  scope :closed   , joins({ticket_statuses: :status}).where('statuses.ticket_status = ?'   , "#{Ticket::CLOSED}")
  scope :overdue  , joins({ticket_statuses: :status}).where('statuses.ticket_status != ? AND due < ?'   , "#{Ticket::SOLVED}", Date.today.to_s)
  scope :today    , joins({ticket_statuses: :status}).where('statuses.ticket_status != ? AND due = ?'   , "#{Ticket::SOLVED}", Date.today.to_s).limit(20)
  scope :upcoming , joins({ticket_statuses: :status}).where('statuses.ticket_status != ? AND due > ?'   , "#{Ticket::SOLVED}", Date.today.to_s).limit(20)
  scope :recent   , limit(20).order("created_at DESC").all

  attr_accessible :title, :description, :ticket_state, :assign_state, :due, :created_at , :student_id, :priority_id, :subject_id, :category_id,
  :date_of_alleged_event, :reason_of_delay,:expectations,:ticket_statuses_attributes, :follow_ups_attributes
  belongs_to :priority
  belongs_to :student
  has_many :ticket_statuses
  has_many :statuses , through: :ticket_statuses
  accepts_nested_attributes_for :ticket_statuses
  has_many :follow_ups
  accepts_nested_attributes_for :follow_ups
  belongs_to :category

  def self.total_timeline
    self.find_by_sql("SELECT (EXTRACT(EPOCH FROM date)*1000) AS date, COALESCE(count,0) AS count
    FROM GENERATE_SERIES(DATE_TRUNC('year', localtimestamp) - interval '1 year', DATE_TRUNC('year', localtimestamp) + interval '1 year -1 day', interval '1 day') AS date
    LEFT OUTER JOIN (SELECT DATE_TRUNC('day', tickets.created_at) AS day, COUNT(tickets.id) AS count
    FROM tickets
    WHERE created_at >= DATE_TRUNC('year', localtimestamp) - interval '1 year' AND created_at < DATE_TRUNC('year', localtimestamp) + interval '1 year -1 day'
    GROUP BY day ORDER BY day ASC) results
    ON (date = results.day)")
  end

  def self.open_timeline
    self.find_by_sql("SELECT (EXTRACT(EPOCH FROM date)*1000) AS date, COALESCE(count,0) AS count
    FROM GENERATE_SERIES(DATE_TRUNC('year', localtimestamp) - interval '1 year', DATE_TRUNC('year', localtimestamp) + interval '1 year -1 day', interval '1 day') AS date
    LEFT OUTER JOIN (SELECT DATE_TRUNC('day', tickets.created_at) AS day, COUNT(tickets.id) AS count
    FROM tickets, ticket_statuses,statuses
    WHERE (tickets.created_at >= DATE_TRUNC('year', localtimestamp) - interval '1 year' AND tickets.created_at < DATE_TRUNC('year', localtimestamp) + interval '1 year -1 day') AND
    tickets.id = ticket_statuses.ticket_id AND ticket_statuses.status_id = statuses.id AND statuses.ticket_status = '#{Ticket::OPEN}'     
    GROUP BY day
    ORDER BY day ASC) results ON (date = results.day)")
  end

  def self.in_progress_timeline
    self.find_by_sql("SELECT (EXTRACT(EPOCH FROM date)*1000) AS date, coalesce(count,0) AS count
    FROM generate_series(date_trunc('year', localtimestamp) - interval '1 year', date_trunc('year', localtimestamp) + interval '1 year -1 day', interval '1 day') AS date
    LEFT OUTER JOIN (SELECT date_trunc('day', tickets.created_at) as day, count(tickets.id) as count
    FROM tickets, ticket_statuses,statuses
    WHERE (tickets.created_at >= date_trunc('year', localtimestamp) - interval '1 year' AND tickets.created_at < date_trunc('year', localtimestamp) + interval '1 year -1 day') AND
    tickets.id = ticket_statuses.ticket_id AND ticket_statuses.status_id = statuses.id AND statuses.ticket_status = '#{Ticket::PROGRESS}'     
    GROUP BY day
    ORDER BY day ASC) results ON (date = results.day)")
  end

  def self.pending_timeline
    self.find_by_sql("SELECT (EXTRACT(EPOCH FROM date)*1000) AS date, coalesce(count,0) AS count
    FROM generate_series(date_trunc('year', localtimestamp) - interval '1 year', date_trunc('year', localtimestamp) + interval '1 year -1 day', interval '1 day') AS date
    LEFT OUTER JOIN (SELECT date_trunc('day', tickets.created_at) as day, count(tickets.id) as count
    FROM tickets, ticket_statuses,statuses
    WHERE (tickets.created_at >= date_trunc('year', localtimestamp) - interval '1 year' AND tickets.created_at < date_trunc('year', localtimestamp) + interval '1 year -1 day') AND
    tickets.id = ticket_statuses.ticket_id AND ticket_statuses.status_id = statuses.id AND statuses.ticket_status = '#{Ticket::PENDING}'     
    GROUP BY day
    ORDER BY day ASC) results ON (date = results.day)")
  end

  def self.solved_timeline
    self.find_by_sql("SELECT (EXTRACT(EPOCH FROM date)*1000) AS date, coalesce(count,0) AS count
    FROM generate_series(date_trunc('year', localtimestamp) - interval '1 year', date_trunc('year', localtimestamp) + interval '1 year -1 day', interval '1 day') AS date
    LEFT OUTER JOIN (SELECT date_trunc('day', tickets.created_at) as day, count(tickets.id) as count
    FROM tickets, ticket_statuses,statuses
    WHERE (tickets.created_at >= date_trunc('year', localtimestamp) - interval '1 year' AND tickets.created_at < date_trunc('year', localtimestamp) + interval '1 year -1 day') AND
    tickets.id = ticket_statuses.ticket_id AND ticket_statuses.status_id = statuses.id AND statuses.ticket_status = '#{Ticket::SOLVED}'     
    GROUP BY day
    ORDER BY day ASC) results ON (date = results.day)")
  end

  def self.closed_timeline
    self.find_by_sql("SELECT (EXTRACT(EPOCH FROM date)*1000) AS date, coalesce(count,0) AS count
    FROM generate_series(date_trunc('year', localtimestamp) - interval '1 year', date_trunc('year', localtimestamp) + interval '1 year -1 day', interval '1 day') AS date
    LEFT OUTER JOIN (SELECT date_trunc('day', tickets.created_at) as day, count(tickets.id) as count
    FROM tickets, ticket_statuses,statuses
    WHERE (tickets.created_at >= date_trunc('year', localtimestamp) - interval '1 year' AND tickets.created_at < date_trunc('year', localtimestamp) + interval '1 year -1 day') AND
    tickets.id = ticket_statuses.ticket_id AND ticket_statuses.status_id = statuses.id AND statuses.ticket_status = '#{Ticket::CLOSED}'     
    GROUP BY day
    ORDER BY day ASC) results ON (date = results.day)")
  end

  def self.high_timeline
    self.find_by_sql("SELECT (EXTRACT(EPOCH FROM date)*1000) AS date, coalesce(count,0) AS count
    FROM generate_series(date_trunc('year', localtimestamp) - interval '1 year', date_trunc('year', localtimestamp) + interval '1 year -1 day', interval '1 day') AS date
    LEFT OUTER JOIN (SELECT date_trunc('day', tickets.created_at) as day, count(tickets.id) as count
    FROM tickets,priorities
    WHERE (tickets.created_at >= date_trunc('year', localtimestamp) - interval '1 year' AND tickets.created_at < date_trunc('year', localtimestamp) + interval '1 year -1 day') AND
    priority_id = priorities.id AND priorities.priority_name = '#{Ticket::HIGH}'
    GROUP BY day
    ORDER BY day ASC) results ON (date = results.day)")
  end

  def self.normal_timeline
    self.find_by_sql("SELECT (EXTRACT(EPOCH FROM date)*1000) AS date, coalesce(count,0) AS count
    FROM generate_series(date_trunc('year', localtimestamp) - interval '1 year', date_trunc('year', localtimestamp) + interval '1 year -1 day', interval '1 day') AS date
    LEFT OUTER JOIN (SELECT date_trunc('day', tickets.created_at) as day, count(tickets.id) as count
    FROM tickets,priorities
    WHERE (tickets.created_at >= date_trunc('year', localtimestamp) - interval '1 year' AND tickets.created_at < date_trunc('year', localtimestamp) + interval '1 year -1 day') AND
    priority_id = priorities.id AND priorities.priority_name = '#{Ticket::NORMAL}'
    GROUP BY day
    ORDER BY day ASC) results ON (date = results.day)")
  end

  def self.low_timeline
    self.find_by_sql("SELECT (EXTRACT(EPOCH FROM date)*1000) AS date, coalesce(count,0) AS count
    FROM generate_series(date_trunc('year', localtimestamp) - interval '1 year', date_trunc('year', localtimestamp) + interval '1 year -1 day', interval '1 day') AS date
    LEFT OUTER JOIN (SELECT date_trunc('day', tickets.created_at) as day, count(tickets.id) as count
    FROM tickets,priorities
    WHERE (tickets.created_at >= date_trunc('year', localtimestamp) - interval '1 year' AND tickets.created_at < date_trunc('year', localtimestamp) + interval '1 year -1 day') AND
    priority_id = priorities.id AND priorities.priority_name = '#{Ticket::LOW}'
    GROUP BY day
    ORDER BY day ASC) results ON (date = results.day)")
  end

  def self.total_priority_details
    self.find_by_sql("SELECT COUNT(*) AS total_complaints,
    COUNT(CASE p.priority_name WHEN '#{Ticket::HIGH}'        THEN 1 END) AS high_complaints,
    COUNT(CASE p.priority_name WHEN '#{Ticket::NORMAL}' THEN 1 END) AS normal_complaints,
    COUNT(CASE p.priority_name WHEN '#{Ticket::LOW}'     THEN 1 END) AS low_complaints
    FROM
    tickets AS t
    JOIN
    priorities AS p
    ON t.priority_id = p.id
    WHERE
    p.priority_name IN ('#{Ticket::HIGH}', '#{Ticket::NORMAL}', '#{Ticket::LOW}')
    ORDER BY total_complaints ASC")
  end

  def self.t_priority_details
    self.find_by_sql("SELECT COUNT(CASE p.priority_name WHEN '#{Ticket::HIGH}' THEN 1 END) AS high_complaints,
    COUNT(CASE p.priority_name WHEN '#{Ticket::NORMAL}' THEN 1 END) AS normal_complaints,
    COUNT(CASE p.priority_name WHEN '#{Ticket::LOW}'     THEN 1 END) AS low_complaints
    FROM
    tickets AS t
    JOIN
    priorities AS p
    ON t.priority_id = p.id
    WHERE
    p.priority_name IN ('#{Ticket::HIGH}', '#{Ticket::NORMAL}', '#{Ticket::LOW}')
    ORDER BY high_complaints ASC")
  end

  def self.subject_priority_details
    self.find_by_sql("SELECT s.subject_title  AS subject_name,s.subject_code AS subject_code,
    COUNT(*) AS total_complaints,
    COUNT(CASE p.priority_name WHEN '#{Ticket::HIGH}'        THEN 1 END) AS high_complaints,
    COUNT(CASE p.priority_name WHEN '#{Ticket::NORMAL}' THEN 1 END) AS normal_complaints,
    COUNT(CASE p.priority_name WHEN '#{Ticket::LOW}'     THEN 1 END) AS low_complaints
    FROM
    tickets AS t
    JOIN
    subjects AS s
    ON  t.subject_id = s.id
    JOIN
    priorities AS p
    ON t.priority_id = p.id
    WHERE
    p.priority_name IN ('#{Ticket::HIGH}', '#{Ticket::NORMAL}', '#{Ticket::LOW}')
    GROUP BY s.subject_title, s.subject_code
    ORDER BY total_complaints ASC")
  end

  def self.category_details
    self.find_by_sql("SELECT COUNT(CASE c.category_name WHEN '#{Ticket::EXAM}' THEN 1 END) AS exam_category,
    COUNT(CASE c.category_name WHEN '#{Ticket::MATERIAL}' THEN 1 END) AS material_category,
    COUNT(CASE c.category_name WHEN '#{Ticket::CLASSROOM}' THEN 1 END) AS classroom_category,
    COUNT(CASE c.category_name WHEN '#{Ticket::INSTRUCTOR}' THEN 1 END) AS instructor_category
    FROM tickets AS t
    JOIN categories AS c
    ON t.category_id = c.id
    WHERE c.category_name IN ('#{Ticket::EXAM}', '#{Ticket::MATERIAL}', '#{Ticket::CLASSROOM}', '#{Ticket::INSTRUCTOR}')
    ORDER BY exam_category ASC")
  end

  def self.staff_total(user)
    self.includes(:ticket_statuses).where("ticket_statuses.staff_id = ?",user.employee.id).count
  end

  def self.staff_high(user)
    self.joins(:ticket_statuses , :priority).where("priorities.priority_name = ? AND ticket_statuses.staff_id = ?", "#{Ticket::HIGH}", user.employee.id).count
  end

  def self.staff_normal(user)
    self.joins(:ticket_statuses , :priority).where("priorities.priority_name = ? AND ticket_statuses.staff_id = ?", "#{Ticket::NORMAL}", user.employee.id).count
  end

  def self.staff_low(user)
    self.joins(:ticket_statuses , :priority).where("priorities.priority_name = ? AND ticket_statuses.staff_id = ?", "#{Ticket::LOW}", user.employee.id).count
  end

  def self.advisor_total(user)
    self.includes(:ticket_statuses).where("ticket_statuses.advisor_id = ?",user.employee.id).count
  end

  def self.advisor_high(user)
    self.joins(:ticket_statuses , :priority).where("priorities.priority_name = ? AND ticket_statuses.advisor_id = ?", "#{Ticket::HIGH}", user.employee.id).count
  end

  def self.advisor_normal(user)
    self.joins(:ticket_statuses , :priority).where("priorities.priority_name = ? AND ticket_statuses.advisor_id = ?", "#{Ticket::NORMAL}", user.employee.id).count
  end

  def self.advisor_low(user)
    self.joins(:ticket_statuses , :priority).where("priorities.priority_name = ? AND ticket_statuses.advisor_id = ?", "#{Ticket::LOW}", user.employee.id).count
  end

  def has_history?
    !self.ticket_statuses.first.versions.last.object.nil?
  end
end
