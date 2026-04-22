#include "types.h"
#include "user.h"

int main(int argc, char *argv[])
{
    int pid;
    int self;
    struct procinfo info;

    if (argc > 2)
    {
        printf(1, "usage: ps [pid]\n");
        exit();
    }

    self = getpid();
    if (argc == 2)
        pid = atoi(argv[1]);
    else
        pid = self;

    if (pid <= 0)
    {
        printf(1, "ps: invalid pid %d\n", pid);
        exit();
    }

    if (getprocinfo(pid, &info) < 0)
    {
        printf(1, "ps: cannot access pid %d (not in your process family or does not exist)\n", pid);
        exit();
    }

    printf(1, " pid=%d\n Parent pid=%d\n Current Process State=%s\n Memory size allocated=%d\n CPU ticks=%d\n Process Name=%s\n",
           info.pid, info.ppid, info.state, info.sz, info.cputicks, info.name);
    exit();
}
