# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

require "universal-queues/single/driver"

##
# Base Universal Queues module.
#

module UniversalQueues
  
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
            # Wrapper according to +algorithm+ library.
            #
            
            module Containers
              
                ##
                # Fibonacci heap queue driver. Uses the +Containers::Heap+ 
                # class from +algorithms+ gem for queueing. Priority is supported.
                #
                
                class Heap < Driver
                    
                    ##
                    # Pushes the value into the queue. Priority is supported.
                    #
                    # @param [Object] value  value for push
                    # @param [Object] key  key for priority queues
                    #
                    
                    def push(value, key = value)
                        @native.push(key, value)
                    end
                    
                    ##
                    # Pops value out of the queue Note, value with minimal 
                    # priority will be popped out.
                    #
                    # @return [Object] queued value
                    #
                    
                    def pop
                        @native.pop
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
                  
                    def clear
                        @native.clear
                    end
                    
                    ##
                    # Returns length of the queue.
                    # @return [Integer]
                    #
                    
                    def length
                        @native.size
                    end
                    
                end
                
              
                ##
                # Fibonacci heap queue driver. Uses the +Containers::PriorityQueue+ 
                # class from +algorithms+ gem for queueing. Priority is supported.
                #
                
                class PriorityQueue < Driver
                    
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
                    # Pops value out of the queue. Value with minimal priority will be 
                    # popped out.
                    #
                    # @return [Object] queued value
                    #
                    
                    def pop
                        @native.pop
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
                  
                    def clear
                        @native.clear
                    end
                    
                    ##
                    # Returns length of the queue.
                    # @return [Integer]
                    #
                    
                    def length
                        @native.size
                    end
                    
                end
            end
        end
    end
end