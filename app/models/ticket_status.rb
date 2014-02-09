# ## Schema Information
#
# Table name: `ticket_statuses`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `integer`          | `not null, primary key`
# **`status_id`**   | `integer`          |
# **`ticket_id`**   | `integer`          |
# **`staff_id`**    | `integer`          |
# **`advisor_id`**  | `integer`          |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
#

class TicketStatus < ActiveRecord::Base
  include Modules::DefaultValues
  has_paper_trail
  before_update :set_staff
  attr_accessible :status_id, :ticket_id , :staff_id, :advisor_id, :previous_advisor_id, :previous_staff_id
  belongs_to :status
  belongs_to :ticket

  belongs_to :staff, class_name: 'Staff', foreign_key: 'staff_id'

  belongs_to :advisor, class_name: 'Advisor', foreign_key: 'advisor_id'
  
  def set_staff
     self.advisor_id = '' if self.staff_id_changed?
   end
  
  def self.advisor_status_details
    self.find_by_sql("SELECT
    em.full_name  AS advisor_name,
    COUNT(*) AS total_complaints,
    COUNT(CASE st.ticket_status WHEN '#{TicketStatus::OPEN}'        THEN 1 END) AS opened_complaints,
    COUNT(CASE st.ticket_status WHEN '#{TicketStatus::PROGRESS}' THEN 1 END) AS in_progress_complaints,
    COUNT(CASE st.ticket_status WHEN '#{TicketStatus::PENDING}'     THEN 1 END) AS pending_complaints,
    COUNT(CASE st.ticket_status WHEN '#{TicketStatus::CLOSED}'      THEN 1 END) AS closed_complaints,
    COUNT(CASE st.ticket_status WHEN '#{TicketStatus::SOLVED}'      THEN 1 END) AS solved_complaints
    FROM
       ticket_statuses AS ti
       JOIN
       employees AS em
         ON  ti.advisor_id = em.id
       JOIN
       statuses AS st
         ON ti.status_id = st.id
    WHERE
       em.type = 'Advisor'
       AND
       st.ticket_status IN ('#{TicketStatus::OPEN}', '#{TicketStatus::PROGRESS}', '#{TicketStatus::PENDING}', '#{TicketStatus::CLOSED}', '#{TicketStatus::SOLVED}')
    GROUP BY
       em.id,
       em.full_name
    ORDER BY em.id")
  end
  
  def self.staff_status_details
    self.find_by_sql("SELECT
      em.full_name  AS staff_name,
      COUNT(*) AS total_complaints,
      COUNT(CASE st.ticket_status WHEN '#{TicketStatus::OPEN}'        THEN 1 END) AS opened_complaints,
      COUNT(CASE st.ticket_status WHEN '#{TicketStatus::PROGRESS}' THEN 1 END) AS in_progress_complaints,
      COUNT(CASE st.ticket_status WHEN '#{TicketStatus::PENDING}'     THEN 1 END) AS pending_complaints,
      COUNT(CASE st.ticket_status WHEN '#{TicketStatus::CLOSED}'      THEN 1 END) AS closed_complaints,
      COUNT(CASE st.ticket_status WHEN '#{TicketStatus::SOLVED}'      THEN 1 END) AS solved_complaints
    FROM
      ticket_statuses AS ti
      JOIN
      employees AS em
        ON  ti.staff_id = em.id
      JOIN
      statuses AS st
        ON ti.status_id = st.id
    WHERE
      em.type = 'Staff'
      AND
      st.ticket_status IN ('#{TicketStatus::OPEN}', '#{TicketStatus::PROGRESS}', '#{TicketStatus::PENDING}', '#{TicketStatus::CLOSED}', '#{TicketStatus::SOLVED}')
    GROUP BY
      em.id,
      em.full_name
    ORDER BY em.id")
  end
  
  def self.total_status_details
    self.find_by_sql("SELECT  COUNT(*) AS total_complaints,
    COUNT(CASE st.ticket_status WHEN '#{TicketStatus::OPEN}'        THEN 1 END) AS opened_complaints,
    COUNT(CASE st.ticket_status WHEN '#{TicketStatus::PROGRESS}' THEN 1 END) AS in_progress_complaints,
    COUNT(CASE st.ticket_status WHEN '#{TicketStatus::PENDING}'     THEN 1 END) AS pending_complaints,
    COUNT(CASE st.ticket_status WHEN '#{TicketStatus::CLOSED}'      THEN 1 END) AS closed_complaints,
    COUNT(CASE st.ticket_status WHEN '#{TicketStatus::SOLVED}'      THEN 1 END) AS solved_complaints
    FROM
       ticket_statuses AS ti
       JOIN
       statuses AS st
         ON ti.status_id = st.id
    WHERE
       st.ticket_status IN ('#{TicketStatus::OPEN}', '#{TicketStatus::PROGRESS}', '#{TicketStatus::PENDING}', '#{TicketStatus::CLOSED}', '#{TicketStatus::SOLVED}')
    ORDER BY total_complaints ASC")
  end
  
  def self.t_status_details
    self.find_by_sql("SELECT COUNT(CASE st.ticket_status WHEN '#{TicketStatus::OPEN}'        THEN 1 END) AS opened_complaints,
    COUNT(CASE st.ticket_status WHEN '#{TicketStatus::PROGRESS}' THEN 1 END) AS in_progress_complaints,
    COUNT(CASE st.ticket_status WHEN '#{TicketStatus::PENDING}'     THEN 1 END) AS pending_complaints,
    COUNT(CASE st.ticket_status WHEN '#{TicketStatus::CLOSED}'      THEN 1 END) AS closed_complaints,
    COUNT(CASE st.ticket_status WHEN '#{TicketStatus::SOLVED}'      THEN 1 END) AS solved_complaints
    FROM
       ticket_statuses AS ti
       JOIN
       statuses AS st
         ON ti.status_id = st.id
    WHERE
       st.ticket_status IN ('#{TicketStatus::OPEN}', '#{TicketStatus::PROGRESS}', '#{TicketStatus::PENDING}', '#{TicketStatus::CLOSED}', '#{TicketStatus::SOLVED}')
    ORDER BY opened_complaints ASC")
  end
  
  def self.staff_statuses(user)
    self.find_by_sql("SELECT COUNT(CASE st.ticket_status WHEN '#{TicketStatus::OPEN}' THEN 1 END) AS opened,
    COUNT(CASE st.ticket_status WHEN '#{TicketStatus::PROGRESS}' THEN 1 END) AS in_progress,
    COUNT(CASE st.ticket_status WHEN '#{TicketStatus::PENDING}' THEN 1 END) AS pending,
    COUNT(CASE st.ticket_status WHEN '#{TicketStatus::CLOSED}' THEN 1 END) AS closed,
    COUNT(CASE st.ticket_status WHEN '#{TicketStatus::SOLVED}' THEN 1 END) AS solved
    FROM
    ticket_statuses AS ti
    JOIN
    statuses AS st
    ON ti.status_id = st.id
    WHERE
    st.ticket_status IN ('#{TicketStatus::OPEN}', '#{TicketStatus::PENDING}', '#{TicketStatus::PROGRESS}', '#{TicketStatus::CLOSED}', '#{TicketStatus::SOLVED}')
    AND ti.staff_id = #{user.employee.id}
    ORDER BY opened ASC")
  end
  
  def self.advisor_statuses(user)
    self.find_by_sql("SELECT COUNT(CASE st.ticket_status WHEN '#{TicketStatus::OPEN}' THEN 1 END) AS opened,
    COUNT(CASE st.ticket_status WHEN '#{TicketStatus::PROGRESS}' THEN 1 END) AS in_progress,
    COUNT(CASE st.ticket_status WHEN '#{TicketStatus::PENDING}' THEN 1 END) AS pending,
    COUNT(CASE st.ticket_status WHEN '#{TicketStatus::CLOSED}' THEN 1 END) AS closed,
    COUNT(CASE st.ticket_status WHEN '#{TicketStatus::SOLVED}' THEN 1 END) AS solved
    FROM
    ticket_statuses AS ti
    JOIN
    statuses AS st
    ON ti.status_id = st.id
    WHERE
    st.ticket_status IN ('#{TicketStatus::OPEN}', '#{TicketStatus::PENDING}', '#{TicketStatus::PROGRESS}', '#{TicketStatus::CLOSED}', '#{TicketStatus::SOLVED}')
    AND ti.advisor_id = #{user.employee.id}
    ORDER BY opened ASC")
  end
end
