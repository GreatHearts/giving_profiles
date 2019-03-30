# frozen_string_literal: true

namespace :check do
  desc "Run all checks on codebase"

  require "rubocop/rake_task"
  RuboCop::RakeTask.new(:rubocop)

  task :lint do
    Rake::Task["check:rubocop:auto_correct"].invoke
  end

  namespace :lint do
    task :no_fix do
      Rake::Task["check:rubocop"].invoke
    end
  end
end

task check: ["check:lint"]
