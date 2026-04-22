#define PSTATE_LEN 16

struct procinfo
{
    int pid;
    int ppid;
    char state[PSTATE_LEN];
    uint sz;
    uint cputicks;
    char name[16];
    int nice;
    int is_privileged;
};

// process-info struct used by kernel and user space