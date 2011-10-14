# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

require "unified-queues/single/driver"
require "hash-utils"

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
            # Queue queue driver. Uses standard library +Queue+ class
            # for thread synchronized queueing. Priority isn't supported.
            #
            
            class QueueDriver < Driver
                
                ##
                # Pushes the value into the queue. Priority isn't supported.
                #
                # @param [Object] value  value for push
                # @param [Object] key  key for priority queues
                #
                
                def push(value, key = value)
                    @native.push(value)
                end
                
                ##
                # Pops value out of the queue.
                #
                # @param [Boolean|Integer] blocking  +true+ or timeout if it should block, +false+ otherwise
                # @param [Object] queue value
                #
                
                def pop(blocking = false)
                    if blocking.boolean?
                        timeout = !blocking
                    else
                        timeout = blocking                        
                    end

                    begin
                        @native.pop(blocking)
                    rescue ThreadError
                        nil
                    end
                end
                
                ##
                # Indicates queue is empty.
                # @param [Boolean] +true+ if it's, +false+ otherwise
                #
                
                def empty?
                    @native.empty?
                end
                
                ##
                # Clears the queue.
                #
              
                def clear!
                    @native.clear
                end
                
                ##
                # Returns length of the queue.
                # @return [Integer]
                #
                
                def length
                    @native.length
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