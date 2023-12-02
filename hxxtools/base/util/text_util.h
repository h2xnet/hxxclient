#ifndef TEXTUTIL_H
#define TEXTUTIL_H

#include <QString>
#include <QDebug>

namespace base {

/*
 * ClassName: TextUtil
 * Desc: 文本处理类
 * Author: zfs
 * Date: 2023-12-02 17:40
 */
class TextUtil
{
public:
    TextUtil();

    /*
     * Function: jsonFileFormat
     * Desc: JSON文件格式化
     * Author: zfs
     * Date: 2023-12-02 17:42
     */
    static int jsonFileFormat(const QString& inputFileName,
                       const QString& outputFileName);

};

} // end namespace base

#endif // TEXTUTIL_H
