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
    my_each do |element|
      result << element if yield element
    end
    result
  end

  # def my_map (&block)
  #   result = []
  #   my_each do |element|
  #     result << block.call(element)
  #   end
  #   result
  # end

end

# (1..10).my_each_with_index{|n, i| puts n if i%2 == 0 }

puts ([1, 2, 3, 4, 5, 6, 7, 8, 9, 10,].my_select{ |x| &:even? })
