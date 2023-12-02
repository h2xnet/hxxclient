#include "schema_data.h"

namespace  {

static QString g_qrc = "qrc";

// file:/// : 绝对路径本地文件名
// file://./ : 相对路径本地文件名
static QString g_file = "file://";

static QString g_path_tag = ":";

static QString g_data = "data";

}

namespace base {

SchemaData::SchemaData()
{

}

SchemaData::~SchemaData() {

}

QString SchemaData::getQrcKey() {
    return g_qrc;
}

QString SchemaData::getFileKey() {
    return g_file;
}

QString SchemaData::getPathTagKey() {
    return g_path_tag;
}

QString SchemaData::getRelativeDataKey() {
    return g_data;
}


} // end namespace base
