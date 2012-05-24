Ruby Unified Queues
===================

**unified-queues** is a unified queue interface which unifies 8 both 
normal and priority queue implementations to the single queue API. 
Usage is simple: 

    require "unified-queues"
    
    # Depq
    require "depq"
    depq_queue = UnifiedQueues::Single::new(Depq)

    # Ruby Array
    array_queue = UnifiedQueues::Single::new(Array)

    # ...the same API!
    depq_queue.push(:foo)
    depq_queue.pop!    # will return :foo

    array_queue.push(:foo)
    array_queue.pop!   # will return :foo

Evented queues are also supported by transparent way; simply provide 
blocks to calls instead of expecting return values.

Currently, the following classes are supported:

    * `Queue` and `Array` (from Ruby),
    * `Depq` (from `depq` gem),
    * `Containers::Heap` (from `algorithms` gem),
    * `CPriorityQueue`, `PoorPriorityQueue`, `RubyPriorityQueue` (from `priority_queue` gem),
    * `EventedQueue` (from `evented-queue` gem).
    
And for multiqueues:
  
    * `UnifiedQueues::Single` (from `unified-queues` gem),
    * `EMJack::Connection` (from `em-jack` gem)

### Multiqueue Support

*Multiqueue* is a queue which is composed of more queues and single 
queue can be selected for writing into or reading from. An example 
of this type of queues are for example some queue servers which 
typically contain more than one queue. By this way, an unified queue 
interface can be implemented for more queue servers too.

Reasonable example isn't available, but see the [QRPC][1] project 
where unified multiqueues are implemented.

Multiqueue driver for single unified queue interface is also 
implemented, so it's possible to build a multiqueue interface from 
the common datatypes or Ruby priority queues implementations by 
an universal and transparent way.

##### Hardcore exmaple

Hardcore example can by for example following (bonus points for 
decoding what it does):
    
    UnifiedQueues::Multi::new UnifiedQueues::Single, ::EM::Wrapper::new(REUQ),  UnifiedQueues::Single, CPriorityQueue

Well, it creates a unified queue interface from the `CPriorityQueue` 
library, wraps it to evented interface (converts standard interface 
to evented one), converts it to the evented unified queue interface 
again and creates a multiqueue interface from it. It may sounds 
difficulty, but it simply *creates evented unified multiqueue 
interface from non-evented proprietary library*. Cool.

Contributing
------------

1. Fork it.
2. Create a branch (`git checkout -b 20101220-my-change`).
3. Commit your changes (`git commit -am "Added something"`).
4. Push to the branch (`git push origin 20101220-my-change`).
5. Create an [Issue][9] with a link to your branch.
6. Enjoy a refreshing Diet Coke and wait.


Copyright
---------

Copyright &copy; 2011 - 2012 [Martin Kozák][10]. See `LICENSE.txt` for
further details.

[1]: http://github.com/martinkozak/qrpc
[9]: http://github.com/martinkozak/unified-queues/issues
[10]: http://www.martinkozak.net/
