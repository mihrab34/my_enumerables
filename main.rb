#!/usr/bin/env ruby

# frozen_string_literal: true

module Enumerable # rubocop:disable Metrics/ModuleLength
  def my_each
    return to_enum unless block_given?
    arr = self.to_a

    i = 0
    while i < size
      yield(arr[i])
      i += 1
    end
  end

  def my_each_with_index
    return to_enum unless block_given?
    arr = self.to_a

    i = 0
    while i < size
      yield(arr[i], i)
      i += 1
    end
  end

  def my_select(&block)
    return to_enum unless block_given?

    result = []
    my_each do |element|
      result << element if yield element
    end
    result
  end
   # rubocop:disable  Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  # def my_map (&block)
  #   result = []
  #   my_each do |element|
  #     result << block.call(element)
  #   end
  #   result
  # end

end

# (1..10).my_each_with_index{|n, i| puts n if i%2 == 0 }
puts [1,'a', 2, 'dog', 'cat', 5, 6, 'be', 'see'].my_select{ |x| x.class==Integer}