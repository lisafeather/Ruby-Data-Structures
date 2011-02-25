# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'queue_as_array'
require 'rubygems'
require 'ruby-debug'

class QueueAsArrayTest < Test::Unit::TestCase
  def test_queue_as_array
    queue = QueueAsArray.new(3)

    assert queue.empty?
    assert !queue.full?

    assert_raise RuntimeError, "Queue Underflow - The queue is empty" do
      queue.dequeue
    end

    queue.enqueue(1)
    assert !queue.empty?
    assert !queue.full?

    assert_equal 1, queue.dequeue
    assert queue.empty?
    assert !queue.full?

    queue.enqueue(1)
    assert !queue.empty?
    assert !queue.full?

    queue.enqueue(2)
    assert !queue.empty?
    assert !queue.full?

    queue.enqueue(3)
    assert !queue.empty?
    assert queue.full?

    assert_raise RuntimeError, "Queue Overflow - The queue is full" do
      queue.enqueue(4)
    end

    assert_equal 1, queue.dequeue
    assert !queue.empty?
    assert !queue.full?

    assert_equal 2, queue.dequeue
    assert !queue.empty?
    assert !queue.full?

    queue.enqueue(7)
    assert !queue.empty?
    assert !queue.full?

    assert_equal 3, queue.dequeue
    assert !queue.empty?
    assert !queue.full?

    assert_equal 7, queue.dequeue
    assert queue.empty?
    assert !queue.full?

    assert_raise RuntimeError, "Queue Underflow - The queue is empty" do
      queue.dequeue
    end
  end

  def test_queue_as_array_reset
    queue = QueueAsArray.new(3)

    assert queue.empty?
    assert !queue.full?

    queue.enqueue(1)
    queue.enqueue(2)

    assert !queue.empty?
    assert !queue.full?

    queue.reset

    assert queue.empty?
    assert !queue.full?
  end
end