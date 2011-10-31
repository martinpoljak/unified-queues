# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

require "hash-utils/array"
require "hash-utils/object"
require "lookup-hash"

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
                    # Tracks currently used queue name.
                    # @return Object
                    #
                    
                    @used_name
                    
                    ##
                    # Tracks currently subscribed queue names.
                    # @return [LookupHash]
                    #
                    
                    @subscribed_names
                     
                    ##
                    # Constructor.
                    #
                    
                    def initialize(cls, *args, &block)
                        @native = cls::new(*args, &block)
                        @subscribed_names = LookupHash["default"]
                        @used_name = "default"
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
                    # Pops value from the queue. Callback is recurring, so it will 
                    # keep callback active after +#pop+.
                    # 
                    # @param [Boolean] blocking  indicates, it should block or not
                    # @return [Object, nil] 
                    #
                    
                    def pop(blocking = false, &block)
                        timeout = blocking ? nil : 0
                        @native.each_job(timeout) do |job|
                            result = job.body
                            job.delete do
                                yield result
                            end
                        end
                    end
                    
                    ##
                    # Sets queue with given name as used. So marks it as target 
                    # for {#push}.
                    #
                    # @param [Object] name name of the required queue 
                    #
                    
                    def use(name, &block)
                        if name != @used_name
                            @used_name = name
                            @native.use(name, &block)
                        elsif not block.nil?
                            EM::next_tick do
                                yield
                            end
                        end
                    end
                    
                    ##
                    # Subscribes to the queue. So marks it as target for {#pop}.
                    # Note, than only single queue can be subscribed at one time.
                    #
                    # @param [Object] name  name of the required queue
                    #
                    
                    def subscribe(name, &block)
                        if not name.in? @subscribed_names
                            @subscribed_names << name
                            @native.watch(name, &block)
                        elsif not block.nil?
                            EM::next_tick do
                                yield
                            end
                        end        
                    end
                    
                    ##
                    # Unsubscribes from the queue.
                    # @param [Object] name  name of the required queue\
                    #
                    
                    def unsubscribe(name, &block)
                        if name.in? @subscribed_names
                            @subscribed_names.delete name
                            @native.ignore(name, &block)
                        elsif not block.nil?
                            EM::next_tick do
                                yield
                            end
                        end
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