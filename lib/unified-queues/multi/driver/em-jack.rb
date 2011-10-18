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
            
            module EMJackDriver
                
                ##
                # Multi queue driver for unified queues single queue interface.
                #
                
                class Connection < Driver
                 
                    ##
                    # Holds native connection object.
                    # @return EMJack::Connection
                    #
                    
                    @native
                     
                    ##
                    # Constructor.
                    #
                    
                    def initialize(cls, *args, &block)
                        @native = cls::new(*args, &block)
                    end
                    
                    ##
                    # Pushes value to the currently used queue.
                    #
                    # @param [Object] value
                    # @param [Integer] key key for priority queues
                    #
                    
                    def push(value, key = value, &block)
                        @native.put(value, :priority => key, &block)
                    end
                    
                    ##
                    # Pops value from the queue. In contrast to default Queue library,
                    # blocks or returns +nil+ if empty.
                    # 
                    # @param [Boolean] blocking  indicates, it should block or not
                    # @return [Object|nil] 
                    #
                    
                    def pop(blocking = false, &block)
                        timeout = blocking ? nil : 0
                        job = @native.reserve(timeout)

                        job.callback do |job|
                            result = job.body
                            @native.delete(job) do 
                                yield result
                            end
                        end
                        job.errback do
                            yield nil
                        end
                    end
                    
                    ##
                    # Sets queue with given name as used. So marks it as target 
                    # for {#push}.
                    #
                    # @param [Object] name name of the required queue 
                    #
                    
                    def use(name, &block)
                        @native.use(name, &block)
                    end
                    
                    ##
                    # Subscribes to the queue. So marks it as target for {#pop}.
                    # Note, than only single queue can be subscribed at one time.
                    #
                    # @param [Object] name  name of the required queue
                    #
                    
                    def subscribe(name, &block)
                        @native.watch(name, &block)        
                    end
                    
                    ##
                    # Unsubscribes from the queue.
                    # @param [Object] name  name of the required queue\
                    #
                    
                    def unsubscribe(name, &block)
                        @native.ignore(name, block)
                    end
                    
                    ##
                    # Currently used queue.
                    # @return [Queue]
                    #
                     
                    def used
                        yield self
                    end
                    
                    ##
                    # Currently subscribed queue.
                    # @return [Queue]
                    #
                        
                    def subscribed
                        yield self
                    end
                        
                    ##
                    # Lists names of all available queues.
                    # @return [Array]
                    #
                    
                    def list(&block)
                        @native.list(&block)
                    end
                    
                    ##
                    # Lists all used queues.
                    # @return [Array]
                    #
                    
                    def list_used(&block)
                        @native.list(:used, &block)
                    end
                
                    ##
                    # Lists all subscribed queues.
                    # @return [Array]
                    #
                        
                    def list_subscribed(&block)
                        @native.list(:watched, &block)
                    end
                    
                end    
            end
        end
    end
end