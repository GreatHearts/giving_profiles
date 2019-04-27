# frozen_string_literal: true

require "rubocop/rake_task"

namespace :lint do
  namespace :rubocop do
    RuboCop::RakeTask.new(:rubocop)

    task :autocorrect do
      puts "Running rubocop w/ auto_correct"
      Rake::Task["lint:rubocop:rubocop:auto_correct"].invoke
    end
    task :no_fix do
      puts "Running rubocop w/out auto_correct"
      Rake::Task["lint:rubocop:rubocop"].invoke
    end
  end

  namespace :erblint do
    # autocorrect doesn't work correctly, shows no errors when they still exist
    # task :autocorrect do
    #   puts "Running erblint w/ autocorrect"
    #   sh "erblint --lint-all --autocorrect"
    # end
    task :no_fix do
      puts "Running erblint w/o autocorrect"
      system("erblint --lint-all")
    end
  end
end
