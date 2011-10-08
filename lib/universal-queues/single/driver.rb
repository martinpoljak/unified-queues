# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

require "abstract"


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
            # Holds native object.
            # @return [Object]
            #
            
            attr_accessor :native
            @native
            
            ##
            # Constructor.
            #
            
            def initialize(_class, *args, &block)
                if self.instance_of? UniversalQueues::Single::Driver
                    not_implemented
                end
                
                @native = _class::new(*args, &block)
            end
            
            ##
            # Pushes the value into the queue.
            #
            # @param [Object] value  value for push
            # @param [Object] key  key for priority queues
            # @abstract
            #
            
            def push(value, key = value)
                not_implemented
            end
            
            alias :<< :push
            
            ##
            # Pops value out of the queue.
            #
            # @param [Object] queue value
            # @abstract
            #
            
            def pop
                not_implemented
            end
            
            ##
            # Indicates queue is empty.
            #
            # @param [Boolean] +true+ if it's, +false+ otherwise
            # @abstract
            #
            
            def empty?
                not_implemented
            end
            
            ##
            # Clears the queue.
            # @abstract
            #
          
            def clear!
                not_implemented
            end
            
            alias :clear :clear! 
            
            ##
            # Returns length of the queue.
            #
            # @return [Integer]
            # @abstract
            #
            
            def length
                not_implemented
            end
        end
        
    end
    
end