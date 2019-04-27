# frozen_string_literal: true

namespace :check do
  desc "Run all checks on codebase"

  task :no_fix do
    Rake::Task["check:audit"].invoke
    Rake::Task["lint:rubocop:no_fix"].invoke
    Rake::Task["lint:erblint:no_fix"].invoke
    Rake::Task["spec"].invoke
  end

  task :audit do
    puts "Running bundle audit"
    system "bundle audit"
  end
end

task check: %w[check:audit lint:rubocop:autocorrect lint:erblint:no_fix spec]
