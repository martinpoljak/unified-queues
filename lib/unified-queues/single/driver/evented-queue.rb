# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

require "unified-queues/single/driver"

##
# Base +Unified Queues+ module.
#

module UnifiedQueues
  
    ##
    # Universal single queue interface.
    #
    
    class Single
      
        ##
        # Abstract single driver class.
        # @abstract
        #
        
        class Driver
          
            ##
            # EventedQueue queue driver. Uses the +EventedQueue+ class
            # from the +evented-queue+ gem. Priority is supported 
            # depending to arguments.
            #
            
            class EventedQueueDriver < Driver
                
                ##
                # Pushes the value into the queue. Priority is supported 
                # depending to arguments.
                #
                # @param [Object] value  value for push
                # @param [Object] key  key for priority queues
                #
                
                def push(value, key = value, &block)
                    @native.push(value, key, &block)
                end
                
                ##
                # Pops value out of the queue.
                #
                # @param [Boolean|Integer] blocking  +true+ or timeout if it should block, +false+ otherwise
                # @param [Object] queue value
                #
                
                def pop(blocking = false, &block)
                    @native.pop(&block)
                end
                
                ##
                # Indicates queue is empty.
                # @param [Boolean] +true+ if it's, +false+ otherwise
                #
                
                def empty?(&block)
                    @native.empty?(&block)
                end
                
                ##
                # Clears the queue.
                #
              
                def clear!(&block)
                    @native.clear(&block)
                end
                
                ##
                # Returns length of the queue.
                # @return [Integer]
                #
                
                def length(&block)
                    @native.length(&block)
                end
                
                ##
                # Returs type of the queue.
                # @return [:linear]
                #
                
                def type
                    :linear
                end
                
            end
        end
        
    end
    
end