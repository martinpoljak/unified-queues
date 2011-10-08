# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

require "abstract"
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
            # Array queue driver.
            #
            
            class Array < Driver
                
                ##
                # Pushes the value into the queue.
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
                # @param [Object] queue value
                # @abstract
                #
                
                def pop
                    @native.shift
                end
                
                ##
                # Indicates queue is empty.
                #
                # @param [Boolean] +true+ if it's, +false+ otherwise
                # @abstract
                #
                
                def empty?
                    @native.empty?
                end
                
                ##
                # Clears the queue.
                # @abstract
                #
              
                def clear
                    @native.clear
                end
                
                ##
                # Returns length of the queue.
                #
                # @return [Integer]
                # @abstract
                #
                
                def length
                    @native.length
                end
                
            end
        end
        
    end
    
end