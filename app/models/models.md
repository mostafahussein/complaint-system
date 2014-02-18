## Schema Information
#
###  Table name: `employees`
#
# Columns
#
 Name                          | Type               | Attributes
 ----------------------------- | ------------------ | ---------------------------
 **`id`**                      | `integer`          | `not null, primary key`
 **`full_name`**               | `string(30)`       |
 **`gender`**                  | `string(6)`        |
 **`type`**                    | `string(15)`       |
 **`user_id`**                 | `integer`          |
 **`employee_department_id`**  | `integer`          |
 **`employee_position_id`**    | `integer`          |
 **`created_at`**              | `datetime`         | `not null`
 **`updated_at`**              | `datetime`         | `not null`
#
# Indexes
#
`index_employees_on_full_name`: **`full_name`** 
#
###  Table name: `answers`
#
# Columns
#
 Name               | Type               | Attributes
 ------------------ | ------------------ | ---------------------------
 **`id`**           | `integer`          | `not null, primary key`
 **`question_id`**  | `integer`          |
 **`content`**      | `string(255)`      |
 **`created_at`**   | `datetime`         | `not null`
 **`updated_at`**   | `datetime`         | `not null`
#
###  Table name: `attends`
#
# Columns
#
 Name              | Type               | Attributes
 ----------------- | ------------------ | ---------------------------
 **`id`**          | `integer`          | `not null, primary key`
 **`student_id`**  | `integer`          |
 **`subject_id`**  | `integer`          |
 **`created_at`**  | `datetime`         | `not null`
 **`updated_at`**  | `datetime`         | `not null`
#
### Table name: `batches`
#
# Columns
#
 Name              | Type               | Attributes
 ----------------- | ------------------ | ---------------------------
 **`id`**          | `integer`          | `not null, primary key`
 **`batch_name`**  | `string(255)`      |
 **`created_at`**  | `datetime`         | `not null`
 **`updated_at`**  | `datetime`         | `not null`
#
###  Table name: `categories`
#
# Columns
#
 Name                 | Type               | Attributes
 -------------------- | ------------------ | ---------------------------
 **`id`**             | `integer`          | `not null, primary key`
 **`category_name`**  | `string(255)`      |
 **`created_at`**     | `datetime`         | `not null`
 **`updated_at`**     | `datetime`         | `not null`
#
###  Table name: `employee_departments`
#
# Columns
#
 Name                   | Type               | Attributes
 ---------------------- | ------------------ | ---------------------------
 **`id`**               | `integer`          | `not null, primary key`
 **`department_name`**  | `string(30)`       |
 **`created_at`**       | `datetime`         | `not null`
 **`updated_at`**       | `datetime`         | `not null`
#
###  Table name: `employee_positions`
#
# Columns
#
 Name                  | Type               | Attributes
 --------------------- | ------------------ | ---------------------------
 **`id`**              | `integer`          | `not null, primary key`
 **`position_title`**  | `string(30)`       |
 **`created_at`**      | `datetime`         | `not null`
 **`updated_at`**      | `datetime`         | `not null`
#
###  Table name: `follow_ups`
#
# Columns
#
 Name               | Type               | Attributes
 ------------------ | ------------------ | ---------------------------
 **`id`**           | `integer`          | `not null, primary key`
 **`text`**         | `string(140)`      |
 **`ticket_id`**    | `integer`          |
 **`user_id`**      | `integer`          |
 **`priority_id`**  | `integer`          |
 **`created_at`**   | `datetime`         | `not null`
 **`updated_at`**   | `datetime`         | `not null`
#
###  Table name: `kbs`
#
# Columns
#
 Name                | Type               | Attributes
 ------------------- | ------------------ | ---------------------------
 **`id`**            | `integer`          | `not null, primary key`
 **`faq_question`**  | `string(255)`      |
 **`faq_answer`**    | `string(255)`      |
 **`category`**      | `string(255)`      |
 **`created_at`**    | `datetime`         | `not null`
 **`updated_at`**    | `datetime`         | `not null`
#
###  Table name: `priorities`
#
# Columns
#
 Name                 | Type               | Attributes
 -------------------- | ------------------ | ---------------------------
 **`id`**             | `integer`          | `not null, primary key`
 **`priority_name`**  | `string(15)`       |
 **`color`**          | `string(10)`       |
 **`background`**     | `string(10)`       |
 **`created_at`**     | `datetime`         | `not null`
 **`updated_at`**     | `datetime`         | `not null`
#
# Indexes
#
 `index_priorities_on_priority_name`: **`priority_name`**
#
### Table name: `questions`
#
# Columns
#
 Name                     | Type               | Attributes
 ------------------------ | ------------------ | ---------------------------
 **`id`**                 | `integer`          | `not null, primary key`
 **`survey_id`**          | `integer`          |
 **`content`**            | `string(255)`      |
 **`created_at`**         | `datetime`         | `not null`
 **`updated_at`**         | `datetime`         | `not null`
 **`question_type`**      | `string(255)`      |
 **`help_text`**          | `string(255)`      |
 **`required_question`**  | `boolean`          | `default(TRUE)`
#
### Table name: `responses`
#
# Columns
#
 Name                   | Type               | Attributes
 ---------------------- | ------------------ | ---------------------------
 **`id`**               | `integer`          | `not null, primary key`
 **`canned_response`**  | `string(255)`      |
 **`created_at`**       | `datetime`         | `not null`
 **`updated_at`**       | `datetime`         | `not null`
#
### Table name: `sections`
#
# Columns
#
 Name                | Type               | Attributes
 ------------------- | ------------------ | ---------------------------
 **`id`**            | `integer`          | `not null, primary key`
 **`section_name`**  | `string(255)`      |
 **`batch_id`**      | `integer`          |
 **`created_at`**    | `datetime`         | `not null`
 **`updated_at`**    | `datetime`         | `not null`
#
###  Table name: `statuses`
#
# Columns
#
 Name                 | Type               | Attributes
 -------------------- | ------------------ | ---------------------------
 **`id`**             | `integer`          | `not null, primary key`
 **`ticket_status`**  | `string(15)`       |
 **`created_at`**     | `datetime`         | `not null`
 **`updated_at`**     | `datetime`         | `not null`
#
# Indexes
#
`index_statuses_on_ticket_status`:**`ticket_status`**
#
### Table name: `students`
#
# Columns
#
 Name              | Type               | Attributes
 ----------------- | ------------------ | ---------------------------
 **`id`**          | `integer`          | `not null, primary key`
 **`full_name`**   | `string(30)`       |
 **`gender`**      | `string(6)`        |
 **`user_id`**     | `integer`          |
 **`batch_id`**    | `integer`          |
 **`section_id`**  | `integer`          |
 **`created_at`**  | `datetime`         | `not null`
 **`updated_at`**  | `datetime`         | `not null`
#
# Indexes
#
`index_students_on_full_name`:**`full_name`**
#
### Table name: `subjects`
#
# Columns
#
 Name                 | Type               | Attributes
 -------------------- | ------------------ | ---------------------------
 **`id`**             | `integer`          | `not null, primary key`
 **`subject_title`**  | `string(255)`      |
 **`subject_code`**   | `string(10)`       |
 **`created_at`**     | `datetime`         | `not null`
 **`updated_at`**     | `datetime`         | `not null`
 **`survey_id`**      | `integer`          |
#
# Indexes
#
`index_subjects_on_subject_title`:**`subject_title`**
#
###  Table name: `subject_staffs`
#
# Columns
#
 Name              | Type               | Attributes
 ----------------- | ------------------ | ---------------------------
 **`id`**          | `integer`          | `not null, primary key`
 **`staff_id`**    | `integer`          |
 **`advisor_id`**  | `integer`          |
 **`subject_id`**  | `integer`          |
 **`created_at`**  | `datetime`         | `not null`
 **`updated_at`**  | `datetime`         | `not null`
#
###  Table name: `subject_surveys`
#
# Columns
#
 Name               | Type               | Attributes
 ------------------ | ------------------ | ---------------------------
 **`id`**           | `integer`          | `not null, primary key`
 **`survey_id`**    | `integer`          |
 **`subject_id`**   | `integer`          |
 **`created_at`**   | `datetime`         | `not null`
 **`updated_at`**   | `datetime`         | `not null`
 **`question_id`**  | `integer`          |
 **`answer_id`**    | `integer`          |
 **`student_id`**   | `integer`          |
#
###  Table name: `surveys`
#
# Columns
#
 Name               | Type               | Attributes
 ------------------ | ------------------ | ---------------------------
 **`id`**           | `integer`          | `not null, primary key`
 **`survey_name`**  | `string(255)`      |
 **`created_at`**   | `datetime`         | `not null`
 **`updated_at`**   | `datetime`         | `not null`
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
# Table name: `users`
#
# ### Columns
#
# Name                          | Type               | Attributes
# ----------------------------- | ------------------ | ---------------------------
# **`id`**                      | `integer`          | `not null, primary key`
# **`email`**                   | `string(60)`       | `default(""), not null`
# **`user_type`**               | `string(10)`       |
# **`role`**                    | `string(30)`       |
# **`active`**                  | `boolean`          | `default(TRUE)`
# **`encrypted_password`**      | `string(255)`      | `default(""), not null`
# **`reset_password_token`**    | `string(255)`      |
# **`reset_password_sent_at`**  | `datetime`         |
# **`remember_created_at`**     | `datetime`         |
# **`sign_in_count`**           | `integer`          | `default(0), not null`
# **`current_sign_in_at`**      | `datetime`         |
# **`last_sign_in_at`**         | `datetime`         |
# **`current_sign_in_ip`**      | `string(255)`      |
# **`last_sign_in_ip`**         | `string(255)`      |
# **`created_at`**              | `datetime`         | `not null`
# **`updated_at`**              | `datetime`         | `not null`
#
# ### Indexes
#
# * `index_users_on_email` (_unique_):
#     * **`email`**
# * `index_users_on_reset_password_token` (_unique_):
#     * **`reset_password_token`**
#