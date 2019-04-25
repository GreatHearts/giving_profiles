# frozen_string_literal: true

namespace :check do
  desc "Run all checks on codebase"

  require "rubocop/rake_task"
  RuboCop::RakeTask.new(:rubocop)

  task :no_fix do
    Rake::Task["check:lint:no_fix"].invoke
    Rake::Task["check:audit"].invoke
  end

  task :lint do
    puts "Running rubocop w/ auto_correct"
    Rake::Task["check:rubocop:auto_correct"].invoke
    bundle exec "erblint --lint-all --autocorrect"
    bundle exec "erblint --lint-all"
  end

  task :audit do
    puts "Running bundle audit"
    bundle exec "bundle audit"
  end

  namespace :lint do
    task :no_fix do
      puts "Running rubocop w/out auto_correct"
      Rake::Task["check:rubocop"].invoke
      bundle exec "erblint --lint-all"
    end
  end
end

task check: %w[check:lint check:audit]
