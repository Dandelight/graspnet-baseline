def memstat():
    with open('/proc/meminfo') as fd:
        for line in fd:
            if line.startswith('MemTotal'):
                MemTotal = line.split()[1]
                continue
            if line.startswith('MemFree'):
                MemFree = line.split()[1]
                break
    print( "总内存：%sM" % (int(MemTotal)/1024))
    print( "剩余内存：%sM" % (int(MemFree)/1024))
