# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

require "hash-utils/module"

##
# Base Universal Queues module.
#

module UniversalQueues
  
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
            :"Containers::PriorityQueue" => "algorithms",
            :CPriorityQueue => "priority_queue",
            :PoorPriorityQueue => "priority_queue",
            :RubyPriorityQueue => "priority_queue" 
        ]
        
        ##
        # Contains driver for specific class instance.
        # @return [UniversalQueues::Single::Abstract] driver instance
        #

        attr_accessor :driver
        @driver
        
        ##
        # Constructor.
        #
        # @param [Class] _class  required class object
        # @param [Array] *args  array of arguments for the queue constructor
        # @param [Proc] &block  block for the queue constructor
        #
      
        def initialize(_class, *args, &block)
            self.assign_driver(_class, args, block)
        end
        
        ##
        # Assigns driver to interface according to given class name.
        #
        # @param [String] classname  name of the required class
        # @param [Array] args  array of arguments for the queue constructor
        # @param [Proc] block  block for the queue constructor
        # 
        
        def assign_driver(_class, args, block)
            classname = _class.name
            driver = nil
            self.class::DRIVERS.each_key do |name|
                begin
                    _module = Module::get_module(name.to_s)
                rescue NameError
                    next
                end
                
                if _class <= _module
                    driver = self.class::DRIVERS[classname.to_sym]
                    break
                end
            end
            
            require "universal-queues/single/driver/" << driver
            _module = Module::get_module("UniversalQueues::Single::Driver::" << classname)
            args = [_class] + args
            @driver = _module::new(*args, &block)
        end
        
        ##
        # Pushes the value into the queue.
        #
        # @param [Object] value  value for push
        # @param [Object] key  key for priority queues
        #
        
        def push(value, key = value)
            @driver.push(value, key)
        end
        
        alias :<< :push
        
        ##
        # Pops value out of the queue.
        # @param [Object] queue value
        #
        
        def pop
            @driver.pop
        end
        
        ##
        # Indicates queue is empty.
        # @param [Boolean] +true+ if it's, +false+ otherwise
        
        def empty?
            @driver.empty?
        end
        
        ##
        # Clears the queue.
        #
      
        def clear!
            @driver.clear!
        end
        
        alias :clear :clear! 
        
        ##
        # Returns length of the queue.
        # @return [Integer]
        #
        
        def length
            @driver.length
        end
    end
end

