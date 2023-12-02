#ifndef LOG_H
#define LOG_H

#include <QString>
#include <QDebug>

namespace base {


class Log
{
public:
    Log();
    ~Log();

    /*
     * Func: clearOldLogFiles
     * Desc: 清理旧日志文件
     * Author: zfs
     * Date: 2023-10-15 20:48
     */
    static int clearOldLogFiles(const QString& prefix, int keepDays = 7);

    static int initLog(const QString& prefix, int logRange);

    static void uninitLog();

private:
    static bool OnLogCanOutput(QtMsgType logMsgType);

    static void messageOutput(QtMsgType type, const QMessageLogContext& context, const QString& msg);

};


} // end namespace base

#endif // LOG_H
