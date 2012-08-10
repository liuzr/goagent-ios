import daemon
from proxy import main

with daemon.DaemonContext():
    main()
