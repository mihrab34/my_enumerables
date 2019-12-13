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
  # rubocop:disable  Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

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

  def my_none?(arg = nil &block)
    !my_any? { arg, block }
  end

  def my_count(arg = nil)
    counter = 0
    if block_given?
      my_each { |elem| counter += 1 if yield(elem) }
    elsif arg.nil?
      my_each { |_elem| counter += 1 }
    else
      my_each { |elem| counter += 1 if elem == arg }
    end
    counter
  end

  def my_map(&block)
    return to_enum unless block_given?

    result = []
    my_each do |elem|
      result << block.call(elem)
    end
    result
  end

  def my_inject(arg = nil, arg2 = nil)
    output = is_a?(Range) ? min : self[0]
    if block_given?
      my_each_with_index { |elem, index| output = yield(output, elem) if index.positive? }
      output = yield(output, arg) if arg
    elsif arg.is_a?(Symbol) || arg.is_a?(String)
      my_each_with_index { |elem, index| output = output.send(arg, elem) if index.positive? }
    elsif arg2.is_a?(Symbol) || arg2.is_a?(String)
      my_each_with_index { |elem, index| output = output.send(arg2, elem) if index.positive? }
      output = output.send(arg2, arg)
    elsif arg
      return "my_inject: #{arg} is not a symbol nor a string"
    else
      return 'my_inject: no block given'
    end
    output
  end
end
# rubocop:enable  Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
