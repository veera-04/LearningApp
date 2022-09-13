# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_09_09_122616) do
  create_table "attempt_responses", force: :cascade do |t|
    t.integer "attempt_id", null: false
    t.integer "question_id", null: false
    t.string "option_selected"
    t.boolean "marked_for_review"
    t.integer "response_answer", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attempt_id"], name: "index_attempt_responses_on_attempt_id"
    t.index ["question_id"], name: "index_attempt_responses_on_question_id"
  end

  create_table "attempts", force: :cascade do |t|
    t.integer "exercise_id", null: false
    t.integer "student_id", null: false
    t.integer "score"
    t.integer "accuracy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_attempts_on_exercise_id"
    t.index ["student_id"], name: "index_attempts_on_student_id"
  end

  create_table "board_classes", force: :cascade do |t|
    t.string "name"
    t.integer "board_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_board_classes_on_board_id"
  end

  create_table "boards", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "logo"
  end

  create_table "chapters", force: :cascade do |t|
    t.string "name"
    t.integer "subject_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_chapters_on_subject_id"
  end

  create_table "contents", force: :cascade do |t|
    t.integer "chapter_id", null: false
    t.integer "content_type", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "content"
    t.index ["chapter_id"], name: "index_contents_on_chapter_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.integer "chapter_id", null: false
    t.string "name"
    t.integer "high_score"
    t.integer "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chapter_id"], name: "index_exercises_on_chapter_id"
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer "resource_owner_id"
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "questions", force: :cascade do |t|
    t.integer "exercise_id", null: false
    t.string "question"
    t.text "options"
    t.string "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_questions_on_exercise_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.string "ph_no"
    t.string "email"
    t.string "dob"
    t.integer "otp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "board_id"
    t.integer "board_class_id"
    t.index ["board_class_id"], name: "index_students_on_board_class_id"
    t.index ["board_id"], name: "index_students_on_board_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.integer "board_class_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_class_id"], name: "index_subjects_on_board_class_id"
  end

  add_foreign_key "attempt_responses", "attempts"
  add_foreign_key "attempt_responses", "questions"
  add_foreign_key "attempts", "exercises"
  add_foreign_key "attempts", "students"
  add_foreign_key "chapters", "subjects"
  add_foreign_key "contents", "chapters"
  add_foreign_key "exercises", "chapters"
  add_foreign_key "questions", "exercises"
  add_foreign_key "subjects", "board_classes"
end
