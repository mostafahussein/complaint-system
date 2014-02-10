# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140209001425) do

  create_table "activities", :force => true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "activities", ["owner_id", "owner_type"], :name => "index_activities_on_owner_id_and_owner_type"
  add_index "activities", ["recipient_id", "recipient_type"], :name => "index_activities_on_recipient_id_and_recipient_type"
  add_index "activities", ["trackable_id", "trackable_type"], :name => "index_activities_on_trackable_id_and_trackable_type"

  create_table "answers", :force => true do |t|
    t.integer  "question_id"
    t.string   "content"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "attends", :force => true do |t|
    t.integer  "student_id"
    t.integer  "subject_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "batches", :force => true do |t|
    t.string   "batch_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "category_name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "employee_departments", :force => true do |t|
    t.string   "department_name", :limit => 30
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "employee_positions", :force => true do |t|
    t.string   "position_title", :limit => 30
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "employees", :force => true do |t|
    t.string   "full_name",              :limit => 30
    t.string   "gender",                 :limit => 6
    t.string   "type",                   :limit => 15
    t.integer  "user_id"
    t.integer  "employee_department_id"
    t.integer  "employee_position_id"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  add_index "employees", ["full_name"], :name => "index_employees_on_full_name"

  create_table "follow_ups", :force => true do |t|
    t.string   "text",        :limit => 140
    t.integer  "ticket_id"
    t.integer  "user_id"
    t.integer  "priority_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "kbs", :force => true do |t|
    t.string   "faq_question"
    t.string   "faq_answer"
    t.string   "category"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "priorities", :force => true do |t|
    t.string   "priority_name", :limit => 15
    t.string   "color",         :limit => 10
    t.string   "background",    :limit => 10
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "priorities", ["priority_name"], :name => "index_priorities_on_priority_name"

  create_table "questions", :force => true do |t|
    t.integer  "survey_id"
    t.string   "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "responses", :force => true do |t|
    t.string   "canned_response"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "sections", :force => true do |t|
    t.string   "section_name"
    t.integer  "batch_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "statuses", :force => true do |t|
    t.string   "ticket_status", :limit => 15
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "statuses", ["ticket_status"], :name => "index_statuses_on_ticket_status"

  create_table "students", :force => true do |t|
    t.string   "full_name",  :limit => 30
    t.string   "gender",     :limit => 6
    t.integer  "user_id"
    t.integer  "batch_id"
    t.integer  "section_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "students", ["full_name"], :name => "index_students_on_full_name"

  create_table "subject_staffs", :force => true do |t|
    t.integer  "staff_id"
    t.integer  "advisor_id"
    t.integer  "subject_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "subject_surveys", :force => true do |t|
    t.integer  "survey_id"
    t.integer  "subject_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "subjects", :force => true do |t|
    t.string   "subject_title"
    t.string   "subject_code",  :limit => 10
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "subjects", ["subject_title"], :name => "index_subjects_on_subject_title"

  create_table "surveys", :force => true do |t|
    t.string   "survey_name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "ticket_statuses", :force => true do |t|
    t.integer  "status_id"
    t.integer  "ticket_id"
    t.integer  "staff_id"
    t.integer  "advisor_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tickets", :force => true do |t|
    t.text     "description"
    t.integer  "student_id"
    t.integer  "subject_id"
    t.integer  "priority_id"
    t.date     "due"
    t.integer  "category_id"
    t.date     "date_of_alleged_event"
    t.text     "reason_of_delay"
    t.text     "expectations"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "tickets", ["id"], :name => "index_tickets_on_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :limit => 60, :default => "",   :null => false
    t.string   "user_type",              :limit => 10
    t.string   "role",                   :limit => 30
    t.boolean  "active",                               :default => true
    t.string   "encrypted_password",                   :default => "",   :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0,    :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at",                                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
