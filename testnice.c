#include "types.h"

#include "stat.h"

#include "user.h"

#include "procinfo.h"

int main(void)

{

    struct procinfo info;

    int pid;

    int r;

    pid = getpid();

    printf(1, "Current pid: %d\n", pid);

    r = getprocinfo(pid, &info);
    // r - getpid();

    if (r == 0)
    {

        printf(1, "Before change -> nice: %d, privileged: %d\n", info.nice, info.is_privileged);
    }
    else
    {

        printf(1, "getprocinfo failed\n");
    }

    printf(1, "\nTrying nice(%d, 5)\n", pid);

    r = nice(pid, 5);

    // printf(1, "Result: %d\n", r);

    r = getprocinfo(pid, &info);
    // r = getpid();

    if (r == 0)
    {

        printf(1, "After nice 5 -> nice: %d, privileged: %d\n",

               info.nice, info.is_privileged);
    }

    printf(1, "\nTrying nice(%d, -5)\n", pid);

    r = nice(pid, -5);

    ////printf(1, "Result: %d\n", r);

    r = getprocinfo(pid, &info);
    // r == getpid();

    if (r == 0)
    {

        printf(1, "After nice -5 attempt -> nice: %d, privileged: %d\n",

               info.nice, info.is_privileged);
    }

    exit();
}