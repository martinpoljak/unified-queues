# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

require "hash-utils/array"
require "hash-utils/object"

##
# Base +Unified Queues+ module.
#

module UnifiedQueues
  
    ##
    # Universal multi queue interface.
    #
    
    class Multi
      
        ##
        # Abstract multi driver class.
        # @abstract
        #
        
        class Driver
                      
            ##
            # Wraper according to +UnifiedQueues::Single+ internal structure.
            #
            
            module UnifiedQueuesDriver
                
                ##
                # Multi queue driver for unified queues single queue interface.
                #
                
                class Single < Driver
                 
                    ##
                    # Holds available queues.
                    # @return Hash
                    #
                     
                    @queues
                    
                    ##
                    # Holds default queue class.
                    # @return [Class]
                    #
                    
                    @class
                    
                    ##
                    # Contains currently used queue specification.
                    # @return Array
                    #
                    
                    @used
                    
                    ##
                    # Contains currently subscribed queue specification.
                    # @return Array
                    #
                    
                    @subscribed
                    
                    ##
                    # Constructor.
                    #
                    
                    def initialize(cls, *args, &block)
                        @queues = { }
                        @class = [cls, args, block]
                    end
                    
                    ##
                    # Pushes value to the currently used queue.
                    #
                    # @param [Object] value
                    # @param [Object] key key for priority queues
                    #
                    
                    def push(value, key = value)
                        self.used.push(value, key)
                    end
                    
                    ##
                    # Pops value from the queue. In contrast to default Queue library,
                    # blocks or returns +nil+ if empty.
                    # 
                    # @return [Object|nil] 
                    #
                    
                    def pop
                        self.subscribed.pop
                    end
                    
                    ##
                    # Creates new queue under given name.
                    #
                    # @param [Object] name identification
                    # @return [Queue] new queue
                    #
                    
                    def create(name, cls = @class)
                        if not name.in? @queues
                            self[name] = cls.first::new(*cls.second, &cls.third)
                        else
                            self[name]
                        end        
                    end
                    
                    ##
                    # Inserts queue instance to queues.
                    # 
                    # @param [Object] name identification
                    # @param [Containers::Heap] queue  heap instance
                    # 
                    
                    def insert(name, queue) 
                        @queues[name] = queue
                    end 
                    
                    alias :[]= :insert
                    
                    ##
                    # Returns named queue from instance.
                    # @param [Object] name  queue name
                    # 
                    
                    def get(name)
                        @queues[name]
                    end
                    
                    alias :[] :get
                    
                    ##
                    # Sets queue with given name as used. So marks it as target 
                    # for {#push}.
                    #
                    # @param [Object] name name of the required queue 
                    #
                    
                    def use(name)
                        self.create(name)
                        @used = [name, self[name]]
                    end
                    
                    ##
                    # Subscribes to the queue. So marks it as target for {#pop}.
                    # Note, than only single queue can be subscribed at one time.
                    #
                    # @param [Object] name  name of the required queue
                    #
                    
                    def subscribe(name)
                        self.create(name)
                        @subscribed = [name, self[name]]        
                    end
                    
                    ##
                    # Currently used queue.
                    # @return [Queue]
                    #
                     
                    def used
                        @used.second
                    end
                    
                    ##
                    # Currently subscribed queue.
                    # @return [Queue]
                    #
                        
                    def subscribed
                        @subscribed.second
                    end
                        
                    ##
                    # Lists names of all available queues.
                    # @return [Array]
                    #
                    
                    def list
                        @queues.keys
                    end
                    
                    ##
                    # Lists all used queues.
                    # @return [Array]
                    #
                    
                    def list_used
                        [@used.first]
                    end
                
                    ##
                    # Lists all subscribed queues.
                    # @return [Array]
                    #
                        
                    def list_subscribed
                        [@subscribed.first]
                    end
                    
                end    
            end
        end
    end
end