# frozen_string_literal: true

namespace :check do
  desc "Run all checks on codebase"

  task :no_fix do
    Rake::Task["lint:rubocop:no_fix"].invoke
    Rake::Task["lint:erblint:no_fix"].invoke
    Rake::Task["check:audit"].invoke
  end

  task :audit do
    puts "Running bundle audit"
    bundle exec "bundle audit"
  end
end

task check: %w[lint:rubocop:autocorrect lint:erblint:no_fix check:audit]
