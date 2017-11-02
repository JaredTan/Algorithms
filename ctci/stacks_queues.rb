def three_in_one

  class MultiStack
    def initialize(stack_size)
      @stack = Array.new(stack_size * 3)
      @stack1_top = 0
      @stack1_bottom = @stack1_top + stack_size - 1
      @stack1_slot = @stack1_bottom
      @stack2_top = @stack1_bottom + 1
      @stack2_bottom = @stack2_top + stack-size - 1
      @stack2_slot = @stack2_bottom
      @stack3_top = @stack2_bottom + 1
      @stack3_bottom = @stack3_top + stack_size - 1
      @stack3_slot = @stack3_bottom
    end

    def pop(stack_num)
      if stack_num == 1
        if @stack1_slot == @stack1_bottom
          return 'Stack 1 is empty!'
        else
          val = @stack[@stack1_slot]
          @stack[@stack1_slot] = nil
          @stack1_slot += 1
          return val
        end
      elsif stack_num == 2
        if @stack2_slot == @stack2_bottom
          return 'Stack 2 is empty!'
        else
          val = @stack[@stack2_slot]
          @stack[@stack2_slot] = nil
          @stack2_slot += 1
          return val
        end
      elsif stack_num == 3
        if @stack3_slot == @stack3_bottom
          return 'Stack 3 is empty!'
        else
          val = @stack[@stack3_slot]
          @stack[@stack3_slot] = nil
          @stack3_slot += 1
          return val
        end
      else
        return 'invalid stack'
      end
    end

    def push(stack_num, val)
      #if stack_num == 1
      if @stack1_slot < @stack1_top
        return 'Stack 1 is full!'
      else
        @stack[@stack1_slot] = val
        @stack1_slot -= 1
      end
      @stack
    end
  end

end

def stack_min
  class MinStack
    def initialize
      @stack = []
      @min_stack = []
    end

    def push(val)
      @stack.unshift(val)
      if @min_stack.empty? || @min_stack[0] > val
        @min_stack.unshift(val)
      end
      @stack
    end

    def pop
      val = @stack.shift
      if @min_stack[0] == val
        @min_stack.shift
      end
      val
    end

    def min
      @min_stack[0]
    end
  end


end

def stack_of_plates
  class SetOfStacks
    def initialize(capacity)
      @set = [[]]
      @capacity = capacity
      @count = 0
      @current_stack = 0
      @replacement_queue = []
    end

    def push
      if @replacement_queue.count > 0
        @set[@replacement_queue.first].push('plate')
        @replacement_queue.shift
      else
        if @count == @capacity
          @set.push([])
          @current_stack += 1
          @count = 0
        else
          @count += 1
        end
      @set[@current_stack].unshift('plate')
    end

    def pop
      if @count == 0
        @set.pop
        @current_stack -= 1
        @count = @capacity
      else
        @count -=1
      end
      @set[@current_stack].shift
    end

    def pop_at(index)
      return 'not a valid stack' if !@set[index]
      @set[index].shift
      @replacement_queue << index
    end
  end

end


def queue_via_stacks

  class MyQueue

    def initialize
      @stack1 = []
      @stack2 = []
    end

    def push(val)
      @stack1.unshift(val)
    end

    def pop(val)
      return 'cannot pop' if @stack1.empty? && @stack2.empty?
      if @stack2.empty?
        while @stack1.length > 0
          @stack2.unshift(@stack1.shift)
        end
      end
      return @stack2.shift
    end

  end


  def soft_stack

    class SoftStack

      def initialize
        @stack = []
      end


      def push(val)
        @stack.unshift(val)
        if !is_empty?
          current_idx = 0
          until current_idx >= @stack.length - 1 || @stack[current_idx] <= @stack[current_idx + 1]
            temp = @stack[current_idx + 1]
            @stack[current_idx + 1] = val
            @stack[current_idx] = temp
            current_idx += 1
          end
        end
        @stack
      end

      def pop
        @stack.shift
      end

      def peek
        @stack[0]
      end

      def is_empty?
        @stack.empty?
      end

    end

  end

  def animal_shelter
    class Dog
      attr_reader :name, :arrival
      def initialize(name, arrival)
        @name = name
        @arrival = arrival
      end
    end

    class Cat
      attr_reader :name, :arrival
      def initialize(name, arrival)
        @name = name
        @arrival = arrival
      end
    end

    class AnimalShelter
     def initialize
       @cats = LinkedList.new
       @dogs = LinkedList.new
     end

     def enqueue(animal)
       if animal.class == Dog
         @dogs.append(animal)
       else
         @cats.append(animal)
       end
     end

     def dequeueAny
       if @dogs.first.arrival < @cats.first.arrival
         return @dogs.shift
       else
         return @cats.shift
       end
     end

     def dequeueCat
       @cats.shift
     end

     def dequeueDog
       @dogs.shift
     end
   end
  end
end
