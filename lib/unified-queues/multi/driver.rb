# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

require "abstract"


##
# Base +Unified Queues+ module.
#

module UnifiedQueues
  
    ##
    # More queues single interface.
    #
    
    class Multi
      
        ##
        # Abstract multi driver class.
        # @abstract
        #
        
        class Driver
          
            ##
            # Holds native object.
            # @return [Object]
            #
            
            attr_accessor :native
            @native
            
            ##
            # Constructor.
            #
            
            def initialize(cls, *args, &block)
                if self.instance_of? UniversalQueues::Multi::Driver
                    not_implemented
                end
                
                @native = cls::new(*args, &block)
            end

            ##
            # Pushes value to the currently used queue.
            #
            # @param [Object] value
            # @abstract
            #
            
            def push(value, &block)
                not_implemented
            end
            
            ##
            # Pops value from the queue. In contrast to default Queue library,
            # blocks or returns +nil+ if empty.
            # 
            # @param [Boolean|Integer] blocking  +true+ or timeout if it should block, +false+ otherwise
            # @return [Object|nil]
            # @abstract 
            #
            
            def pop(blocking = false, &block)
                not_implemented
            end
    
            ##
            # Sets queue with given name as used. So marks it as target 
            # for {#push}.
            #
            # @param [Object] name name of the required queue
            # @abstract 
            #
            
            def use(name, &block)
                not_implemented
            end
            
            ##
            # Subscribes to the queue. So marks it as target for {#pop}.
            # Note, than only single queue can be subscribed at one time.
            #
            # @param [Object] name  name of the required queue
            # @abstract
            #
            
            def subscribe(name, &block)
                not_implemented
            end
            
            ##
            # Unsubscribes from the queue.
            #
            # @param [Object] name  name of the required queue\
            # @abstract
            #
            
            def unsubscribe(name, &block)
                not_implemented
            end
            
            ##
            # Currently used queue.
            #
            # @return [Queue]
            # @abstract
            #
             
            def used(&block)
                not_implemented
            end
            
            ##
            # Currently subscribed queue.
            #
            # @return [UniversalQueues::Single]
            # @abstract
            #
                
            def subscribed(&block)
                not_implemented
            end
                
            ##
            # Lists names of all available queues.
            #
            # @return [Array]
            # @abstract
            #
            
            def list(&block)
                not_implemented
            end
            
            ##
            # Lists all used queues.
            #
            # @return [Array]
            # @abstract
            #
            
            def list_used(&block)
                not_implemented
            end
        
            ##
            # Lists all subscribed queues.
            #
            # @return [Array]
            # @abstract
            #
                
            def list_subscribed(&block)
                not_implemented
            end

            ##
            # Closes the session.
            #
            
            def close(&block)
                yield if not block.nil?
            end
            
            alias :close! :close
           
        end
    end
end