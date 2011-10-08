Callback Locker
===============

"Locker" is lockable box for equipment -- at this case box for 
collecting the callbacks (in ites locked state) and running them 
after unlocking. So, in fact, it serves as some kind of callback 
semaphore or mutex. 

Some trivial example:

    require "callback-locker"
    locker = CallbackLocker::new
    
    foo = nil
    locker.synchronize do
        foo = "bar"
    end
    
    # ^^^ locker is unlocked, so #synchronize will execute callback
    #     immediately 
    
    foo = nil
    locker.lock!
    locker.synchronize do
        foo = "1"
    end
    locker.synchronize do
        foo << "2"
    end
    locker.unlock!
    
    # ^^^ locker is locked, so callbacks are stacked and executed
    #     immediately after the #unlock! method is call, so foo
    #     will contain "12"

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

Copyright &copy; 2011 [Martin Kozák][10]. See `LICENSE.txt` for
further details.

[8]: http://rubyeventmachine.com/
[9]: http://github.com/martinkozak/callback-adapter/issues
[10]: http://www.martinkozak.net/
