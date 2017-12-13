#ifndef FILEREADER_H
#define FILEREADER_H

#include <QObject>

class FileReader : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE QString readFile(const QString &fileName);
};



#endif // FILEREADER_H
