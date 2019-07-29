# frozen_string_literal: true

unless Rails.env.production?
  require "rubocop/rake_task"

  namespace :lint do
    namespace :rubocop do
      RuboCop::RakeTask.new(:rubocop)

      desc "Run RuboCop with auto_correct."

      task :autocorrect do
        puts "Running RuboCop w/ auto_correct"
        Rake::Task["lint:rubocop:rubocop:auto_correct"].invoke
      end

      desc "Run RuboCop without auto_correct."

      task :no_fix do
        puts "Running RuboCop w/out auto_correct"
        Rake::Task["lint:rubocop:rubocop"].invoke
      end
    end

    namespace :erblint do
      task :autocorrect do
        puts "Running erblint w/ autocorrect"
        sh "erblint --lint-all --autocorrect"
      end

      desc "Check for ERBLint without autocorrect."

      task :no_fix do
        puts "Running erblint w/o autocorrect"
        system("erblint --lint-all")
      end
    end
  end
end
