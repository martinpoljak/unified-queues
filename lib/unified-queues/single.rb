# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

require "hash-utils/module"

##
# Base +Unified Queues+ module.
#

module UnifiedQueues
  
    ##
    # Universal single queue interface.
    #
    
    class Single
        
        ##
        # Contains assignment of classnames to drivers.
        # @return [Hash] 
        #
          
        DRIVERS = Hash[
            :Queue => "queue",
            :Array => "array",
            :Depq => "depq",
            :"Containers::Heap" => "algorithms",
            :CPriorityQueue => "priority_queue",
            :PoorPriorityQueue => "priority_queue",
            :RubyPriorityQueue => "priority_queue" 
        ]
        
        ##
        # Contains driver for specific class instance.
        # @return [UnifiedQueues::Single::Driver] driver instance
        #

        attr_accessor :driver
        @driver
        
        ##
        # Constructor.
        #
        # @param [Class] cls  required class object
        # @param [Array] *args  array of arguments for the queue constructor
        # @param [Proc] &block  block for the queue constructor
        #
      
        def initialize(cls, *args, &block)
            self.assign_driver(cls, args, block)
        end
        
        ##
        # Assigns driver to interface according to given class name.
        #
        # @param [Class] cls  required class
        # @param [Array] args  array of arguments for the queue constructor
        # @param [Proc] block  block for the queue constructor
        # 
        
        def assign_driver(cls, args, block)
            classname = cls.name
            driver = nil
            self.class::DRIVERS.each_key do |name|
                begin
                    _module = Module::get_module(name.to_s)
                rescue NameError
                    next
                end
                
                if cls <= _module
                    driver = self.class::DRIVERS[classname.to_sym]
                    break
                end
            end
            
            require "unified-queues/single/driver/" << driver
            
            path = classname.split("::")
            classname = path.shift << 'Driver::' << path.join('::')
            _module = Module::get_module("UnifiedQueues::Single::Driver::" << classname)
            
            args = [cls] + args
            @driver = _module::new(*args, &block)
        end
        
        ##
        # Pushes the value into the queue.
        #
        # @param [Object] value  value for push
        # @param [Object] key  key for priority queues
        #
        
        def push(value, key = value, &block)
            @driver.push(value, key, &block)
        end
        
        alias :<< :push
        
        ##
        # Pops value out of the queue.
        # @param [Object] queue value
        #
        
        def pop(&block)
            @driver.pop(&block)
        end
        
        ##
        # Indicates queue is empty.
        # @param [Boolean] +true+ if it's, +false+ otherwise
        #
        
        def empty?(&block)
            @driver.empty?(&block)
        end
        
        ##
        # Clears the queue.
        #
      
        def clear!(&block)
            @driver.clear!(&block)
        end
        
        alias :clear :clear! 
        
        ##
        # Returns length of the queue.
        # @return [Integer]
        #
        
        def length(&block)
            @driver.length(&block)
        end
        
        alias :size :length
        
=begin
        protected
        
        ##
        # Returns value using yield or return according to driver settings.
        #
        # @return [Object]  returned value
        # @yield [Object] returned value
        #
        
        def __return
            if @driver.linear?
              
            end
        end
=end
    end
end
