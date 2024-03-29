# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

require "unified-queues/single/driver"
require "abstract"

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
            # Fibonacci heap queue driver. Uses the +CPriorityQueue+ class
            # from +PriorityQueue+ gem. Priority is supported.
            #
            # It isn't implement equivalent of the +#clear+ method, so
            # it falls backs to naive "popping" style clearing.
            #
            
            class CPriorityQueueDriver < Driver
                
                ##
                # Pushes the value into the queue. Priority is supported.
                #
                # @param [Object] value  value for push
                # @param [Object] key  key for priority queues
                #
                
                def push(value, key = value)
                    key = (key.kind_of? Integer) ? key : 0
                    @native.push(value, key)
                end
                
                ##
                # Pops value out of the queue. Note, value with minimal 
                # priority will be popped out. Blocking isn'ŧ supported.
                #
                # @param [Boolean|Integer] blocking  +true+ or timeout if it should block, +false+ otherwise
                # @return [Object] queued value
                #
                
                def pop(blocking = false)
                    @native.delete_min_return_key
                end
                
                ##
                # Indicates queue is empty.
                # @param [Boolean] +true+ if it's, +false+ otherwise
                #
                
                def empty?
                    @native.empty?
                end
                
                ##
                # Returns length of the queue.
                #
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

            ##
            # Minimal priority queue driver. Uses the +PoorPriorityQueue+ class
            # from +PriorityQueue+ gem. Priority is supported.
            #
            # It isn't implement equivalent of the +#clear+ method, so
            # it falls backs to naive "popping" style clearing.
            #
            # Also note, it's very minimalistic implementation, so both calls
            # to {PoorPriorityQueue#length} and {PoorPriorityQueue#empty?}
            # will throw an exception.
            #
            
            class PoorPriorityQueueDriver < Driver
                
                ##
                # Pushes the value into the queue. Priority is supported.
                #
                # @param [Object] value  value for push
                # @param [Object] key  key for priority queues
                #
                
                def push(value, key = value)
                    @native.push(value, key)
                end
                
                ##
                # Pops value out of the queue. Note, value with minimal 
                # priority will be popped out. Blocking isn't supported.
                #
                # @param [Boolean|Integer] blocking  +true+ or timeout if it should block, +false+ otherwise
                # @return [Object] queued value
                #
                
                def pop(blocking = false)
                    @native.delete_min_return_key
                end
                
                ##
                # Indicates queue is empty. Note, it isn't implemented
                # in this implementation.
                #
                # @param [Boolean] +true+ if it's, +false+ otherwise
                #
                
                def empty?
                    not_implemented
                end
                
                ##
                # Returns length of the queue. Note, it isn't implemented
                # in this implementation.
                #
                # @return [Integer]
                #
                
                def length
                    not_implemented
                end
                
            end

            ##
            # Ruby fibonacci heap priority queue driver. Uses the +RubyPriorityQueue+ class
            # from +PriorityQueue+ gem. Priority is supported.
            #
            # It isn't implement equivalent of the +#clear+ method, so
            # it falls backs to naive "popping" style clearing.
            #
            
            class RubyPriorityQueueDriver < Driver
                
                ##
                # Pushes the value into the queue. Priority is supported.
                #
                # @param [Object] value  value for push
                # @param [Object] key  key for priority queues
                #
                
                def push(value, key = value)
                    @native.push(value, key)
                end
                
                ##
                # Pops value out of the queue. Note, value with minimal 
                # priority will be popped out. Blocking isn't supported.
                #
                # @param [Boolean|Integer] blocking  +true+ or timeout if it should block, +false+ otherwise
                # @return [Object] queued value
                #
                
                def pop(blocking = false)
                    @native.delete_min_return_key
                end
                
                ##
                # Indicates queue is empty. Note, it isn't implemented
                # in this implementation.
                #
                # @param [Boolean] +true+ if it's, +false+ otherwise
                #
                
                def empty?
                    @native.empty?
                end
                
                ##
                # Returns length of the queue. Note, it isn't implemented
                # in this implementation.
                #
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