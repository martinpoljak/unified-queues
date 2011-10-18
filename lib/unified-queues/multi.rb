# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

require "hash-utils/module"

##
# Base 9Unified Queues+ module.
#

module UnifiedQueues
      
    ##
    # More queues single interface.
    #
    
    class Multi
        
        ##
        # Contains assignment of classnames to drivers.
        # @return [Hash] 
        #
          
        DRIVERS = Hash[
            :"UnifiedQueues::Single" => "unified-queues.rb",
            :"EMJack::Connection" => "em-jack.rb"
        ]

        ##
        # Contains driver for specific class instance.
        # @return [UnifiedQueues::Multi::Driver] driver instance
        #

        attr_accessor :driver
        @driver
        
        ##
        # Constructor.
        #
        # @param [Class|UnifiedQueues::Multi::Driver] cls  required class object or driver instance
        # @param [Array] *args  array of arguments for the queue constructor
        # @param [Proc] &block  block for the queue constructor
        #
        
        def initialize(cls, *args, &block)
            if cls.kind_of? UnifiedQueues::Multi::Driver
                @driver = cls
            else
                self.assign_driver(cls, args, block)
            end
        end
        
        ##
        # Assigns driver to interface according to given class name.
        #
        # @param [Class] cls  required class
        # @param [Array] args  array of arguments for the queue constructor
        # @param [Proc] block  block for the queue constructor
        # @return [UnifiedQueues::Multi::Driver] new driver instance
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
            
            require "unified-queues/multi/driver/" << driver
            
            path = classname.split("::")
            classname = path.shift << 'Driver::' << path.join('::')
            _module = Module::get_module("UnifiedQueues::Multi::Driver::" << classname)

            args = [cls] + args
            @driver = _module::new(*args, &block)
            return @driver
        end
        
        ##
        # Pushes value to the currently used queue.
        #
        # @param [Object] value
        # @param [Object] key key for priority purposes
        #
        
        def push(value, key = value, &block)
            @driver.push(value, key, &block)
        end
        
        ##
        # Pops value from the queue. In contrast to default Queue library,
        # blocks or returns +nil+ if empty.
        # 
        # @param [Boolean|Integer] blocking  +true+ or timeout if it should block, +false+ otherwise
        # @return [Object|nil] 
        #
        
        def pop(blocking = false, &block)
            @driver.pop(blocking, &block)
        end
        
        ##
        # Sets queue with given name as used. So marks it as target 
        # for {#push}.
        #
        # @param [Object] name name of the required queue 
        #
        
        def use(name, &block)
            @driver.use(name, &block)
        end
        
        ##
        # Subscribes to the queue. So marks it as target for {#pop}.
        # Note, than only single queue can be subscribed at one time.
        #
        # @param [Object] name  name of the required queue
        #
        
        def subscribe(name, &block)
            @driver.subscribe(name, &block)
        end
        
        ##
        # Currently used queue.
        # @return [Queue]
        #
         
        def used(&block)
            @driver.used(&block)
        end
        
        ##
        # Currently subscribed queue.
        # @return [Queue]
        #
            
        def subscribed(&block)
            @driver.subscribed(&block)
        end
            
        ##
        # Lists names of all available queues.
        # @return [Array]
        #
        
        def list(&block)
            @driver.list(&block)
        end
        
        ##
        # Lists all used queues.
        # @return [Array]
        #
        
        def list_used(&block)
            @driver.list_used(&block)
        end
    
        ##
        # Lists all subscribed queues.
        # @return [Array]
        #
            
        def list_subscribed(&block)
            @driver.list_subscribed(&block)
        end
        
    end
end