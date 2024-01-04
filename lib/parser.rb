#!/usr/bin/env ruby
# frozen_string_literal: true
require 'yaml'

class AnsibleParser
  def self.parse(yaml_data)
    tasks = YAML.safe_load(yaml_data)

    parsed_tasks = tasks.map do |task_data|
      metadata = {}

      metadata[:name] = task_data['name']
      metadata[:tags] = task_data['tags'] if task_data['tags']

      # Extract module arguments (customize as needed)
      metadata[:module] = task_data.keys.find { |key| key != 'name' && key != 'tags' }
      metadata[:module_args] = task_data[metadata[:module]] if metadata[:module]

      metadata[:with_items] = task_data['with_items'] if task_data['with_items']

      # Handle blocks (nested tasks)
      if task_data['block']
        metadata[:block_tasks] = parse(task_data['block'].to_yaml)
      end

      [task_data, metadata]
    end

    parsed_tasks
  end
end

tasks = "/home/b08x/Workspace/syncopatedIaC/roles/audio/tasks/tuning.yml"

task_file_content = File.read(tasks)

parsed_tasks = AnsibleParser.parse(task_file_content)

parsed_tasks.each do |task_data, metadata|
  puts "-------------------------------------------"
  puts "Task name: #{metadata[:name]}"
  puts "Tags: #{metadata[:tags]}"
  puts "Module: #{metadata[:module]}"
  puts "Module arguments: #{metadata[:module_args]}"
  puts "With Items: #{metadata[:with_items]}" if metadata[:with_items]
  puts "\n\n"
  puts "-------------------------------------------"
  # Access other metadata and block_tasks as needed
end
