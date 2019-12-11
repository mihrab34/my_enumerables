#!/usr/bin/env ruby

# frozen_string_literal: true

module Enumerable
  def my_each
    return to_enum unless block_given?

    arr = to_a

    i = 0
    while i < size
      yield(arr[i])
      i += 1
    end
  end

  def my_each_with_index
    return to_enum unless block_given?

    arr = to_a

    i = 0
    while i < size
      yield(arr[i], i)
      i += 1
    end
  end

  def my_select
    return to_enum unless block_given?

    result = []
    my_each do |elem|
      result << elem if yield elem
    end
    result
  end
#rubocop:disable  Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  def my_all?(arg = nil)
    if block_given?
      my_each { |elem| return false unless yield(elem) }
    elsif arg.class == Class
      my_each { |elem| return false unless elem.class.ancestors.include? arg }
    elsif arg.class == Regexp
      my_each { |elem| return false unless elem =~ arg }
    elsif arg.nil?
      my_each { |elem| return false unless elem }
    else
      my_each { |elem| return false unless elem == arg }
    end
  end

  def my_any?(arg = nil)
    if block_given?
      my_each { |elem| return true if yield(elem) }
    elsif arg.class == Class
      my_each { |elem| return true if elem.class.ancestors.include? arg }
    elsif arg.class == Regexp
      my_each { |elem| return true if elem =~ arg }
    elsif arg.nil?
      my_each { |elem| return true if elem }
    else
      my_each { |elem| return true if elem == arg }
    end
  end

  def my_none?(arg = nil)
    if block_given?
      my_each { |elem| return false if yield(elem) }
    elsif arg.class == Class
      my_each { |elem| return false if elem.class.ancestors.include? arg }
    elsif arg.class == Regexp
      my_each { |elem| return false if elem =~ arg }
    elsif arg.nil?
      my_each { |elem| return false if elem }
    else
      my_each { |elem| return false if elem == arg }
    end
  end

  def my_count(arg = nil)
    counter = 0
    if block_given?
      my_each { |elem| counter += 1 if yield(elem) }
    elsif arg.nil?
      my_each { |_elem| counter += 1}
    else
      my_each { |elem| counter += 1 if elem == arg }
    end
    counter
  end

  def my_map (&block)
    return to_enum unless block_given?

    result = []
    my_each do |elem|
      result << block.call(elem)
    end
    result
  end
end
#rubocop:enable  Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
