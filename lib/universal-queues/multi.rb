# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

require "hash-utils/module"

##
# Base Universal Queues module.
#

module UniversalQueues
      
    ##
    # More queues single interface.
    #
    
    class Multi
        
        ##
        # Contains assignment of classnames to drivers.
        # @return [Hash] 
        #
          
        DRIVERS = Hash[
            :"UniversalQueues::Single" => "unified-queues.rb",
#            :"UniversalQueues::Multi" => "unified-queues.rb"
        ]

        ##
        # Contains driver for specific class instance.
        # @return [UniversalQueues::Multi::Driver] driver instance
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
                
                if _class <= _module
                    driver = self.class::DRIVERS[classname.to_sym]
                    break
                end
            end
            
            require "universal-queues/multi/driver/" << driver
            _module = Module::get_module("UniversalQueues::Multi::Driver::" << classname)
            args = [_class] + args
            @driver = _module::new(*args, &block)
        end
        
        ##
        # Pushes value to the currently used queue.
        # @param [Object] value
        #
        
        def push(value, &block)
        end
        
        ##
        # Pops value from the queue. In contrast to default Queue library,
        # blocks or returns +nil+ if empty.
        # 
        # @param [Boolean] nonblock  +true+ if it should block, +false+ othwrwise
        # @return [Object|nil] 
        #
        
        def pop(&block)
        end
        
        ##
        # Creates new queue under given name.
        #
        # @param [Object] name identification
        # @return [Queue] new queue
        #
        
        def create(name, cls = @class, &block)
        end
        
        ##
        # Inserts queue instance to queues.
        # 
        # @param [Object] name identification
        # @param [Object] queue  heap instance
        # 
        
        def insert(name, queue, &block) 
        end 
        
        alias :[]= :insert
        
        ##
        # Returns named queue from instance.
        # @param [Object] name  queue name
        # 
        
        def get(name, &block)
        end
        
        alias :[] :get
        
        ##
        # Sets queue with given name as used. So marks it as target 
        # for {#push}.
        #
        # @param [Object] name name of the required queue 
        #
        
        def use(name, &block)
        end
        
        ##
        # Subscribes to the queue. So marks it as target for {#pop}.
        # Note, than only single queue can be subscribed at one time.
        #
        # @param [Object] name  name of the required queue
        #
        
        def subscribe(name, &block)
        end
        
        ##
        # Currently used queue.
        # @return [Queue]
        #
         
        def used(&block)
        end
        
        ##
        # Currently subscribed queue.
        # @return [Queue]
        #
            
        def subscribed(&block)
        end
            
        ##
        # Lists names of all available queues.
        # @return [Array]
        #
        
        def list(&block)
        end
        
        ##
        # Lists all used queues.
        # @return [Array]
        #
        
        def list_used(&block)
        end
    
        ##
        # Lists all subscribed queues.
        # @return [Array]
        #
            
        def list_subscribed(&block)
        end
        
    end
end