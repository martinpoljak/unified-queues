# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

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
            # Holds native object.
            # @return [Object]
            #
            
            attr_accessor :native
            @native
            
            ##
            # Constructor.
            #
            
            def initialize(cls, *args, &block)
                if self.instance_of? UnifiedQueues::Single::Driver
                    not_implemented
                end
                
                if cls.kind_of? Class
                    @native = cls::new(*args, &block)
                else
                    @native = cls
                end
            end
            
            ##
            # Pushes the value into the queue.
            #
            # @param [Object] value  value for push
            # @param [Object] key  key for priority queues
            # @abstract
            #
            
            def push(value, key = value, &block)
                not_implemented
            end
            
            alias :<< :push
            
            ##
            # Pops value out of the queue.
            #
            # @param [Boolean|Integer] blocking  +true+ or timeout if it should block, +false+ otherwise
            # @param [Object] queue value
            # @abstract
            #
            
            def pop(blocking = false, &block)
                not_implemented
            end
            
            ##
            # Indicates queue is empty.
            #
            # @param [Boolean] +true+ if it's, +false+ otherwise
            # @abstract
            #
            
            def empty?(&block)
                not_implemented
            end
            
            ##
            # Clears the queue.
            # @abstract
            #
          
            def clear!(&block)
                while not self.pop.nil?
                end
            end 
            
            alias :clear :clear! 
            
            ##
            # Returns length of the queue.
            #
            # @return [Integer]
            # @abstract
            #
            
            def length(&block)
                not_implemented
            end
            
            alias :size :length
            
            ##
            # Returs type of the queue. Queue can be +:linear+ which means,
            # calls values are returned using +return+ or +:evented+
            # which indicates necessity of callbacks.
            #
            # @return [:linear, :evented]
            # @abstract
            #
            
            def type
                not_implemented
            end 
            
            ##
            # Indicates, driver is evented so expexts callbacks.
            # @return [Boolean] +true+ if it is, +false+ otherwise
            # 
            
            def evented?
                self.type == :evented
            end
            
            ##
            # Indicates, driver is evented so expexts callbacks.
            # @return [Boolean] +true+ if it is, +false+ otherwise
            # 
            
            def linear?
                self.type == :linear
            end
            
        end
        
    end
    
end