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
            # Array queue driver. Uses standard library +Array+ class
            # for queueing. Priority isn't supported.
            #
            
            class ArrayDriver < Driver
                
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
                # Pops value out of the queue. Blocking isn'ŧ supported.
                #
                # @param [Boolean|Integer] blocking  +true+ or timeout if it should block, +false+ otherwise
                # @return [Object] out-queued value
                #
                
                def pop(blocking = false)
                    @native.shift
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