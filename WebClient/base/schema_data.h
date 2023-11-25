#ifndef SCHEMA_DATA_H
#define SCHEMA_DATA_H

#include <QString>

namespace base {



class SchemaData
{
public:
    SchemaData();
    virtual ~SchemaData();

    static QString getQrcKey();

    static QString getFileKey();

    static QString getPathTagKey();

    static QString getRelativeDataKey();

};


} // end namespace base

#endif // SCHEMA_DATA_H
