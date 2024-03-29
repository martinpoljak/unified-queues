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
                    
                    def push(value, key = value, &block)
                        self.used.push(value, key, &block)
                    end
                    
                    ##
                    # Pops value from the queue. In contrast to default Queue library,
                    # blocks or returns +nil+ if empty.
                    # 
                    # @param [Boolean|Integer] blocking  +true+ or timeout if it should block, +false+ otherwise
                    # @return [Object|nil] 
                    #
                    
                    def pop(blocking = false, &block)
                        self.subscribed.pop(blocking, &block)
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
                    
                    def use(name, &block)
                        self.create(name)
                        @used = [name, self[name]]
                        yield if not block.nil?
                    end
                    
                    ##
                    # Subscribes to the queue. So marks it as target for {#pop}.
                    # Note, than only single queue can be subscribed at one time.
                    #
                    # @param [Object] name  name of the required queue
                    #
                    
                    def subscribe(name, &block)
                        self.create(name)
                        @subscribed = [name, self[name]]
                        yield if not block.nil?        
                    end
                    
                    ##
                    # Unsubscribes from the queue.
                    # @param [Object] name  name of the required queue\
                    #
                    
                    def unsubscribe(name, &block)
                        if not @subscribed.nil? and (@subscribed.first == name)
                            @subscribed = nil
                        end
                        
                        yield if not block.nil?
                    end
                    
                    ##
                    # Currently used queue.
                    # @return [Queue]
                    #
                     
                    def used(&block)
                        yield @used.second if not block.nil?
                        return @used.second
                    end
                    
                    ##
                    # Currently subscribed queue.
                    # @return [Queue]
                    #
                        
                    def subscribed(&block)
                        yield @subscribed.second if not block.nil?
                        return @subscribed.second
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