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
            # Implicit heap queue driver. Uses the +Depq+ class from +depq+ gem
            # for queueing. Priority is supported.
            #
            
            class DepqDriver < Driver
                
                ##
                # Pushes the value into the queue. Priority is supported.
                #
                # @param [Object] value  value for push
                # @param [Object] key  key for priority queues
                #
                
                def push(value, key = value)
                    @native.insert(value, key)
                end
                
                ##
                # Pops value out of the queue. Note, value with minimal 
                # priority will be popped out. Blocking isn'ŧ supported.
                #
                # @param [Boolean|Integer] blocking  +true+ or timeout if it should block, +false+ otherwise
                # @return [Object] queued value
                #
                
                def pop(blocking = false)
                    @native.delete_min
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
                    @native.size
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