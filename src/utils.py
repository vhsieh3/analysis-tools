from sqlalchemy import create_engine
from urllib.parse import quote_plus as urlquote


def create_sql_db(creds):
    """
    Creates a SQl engine while worthing in Python
    creds: dictionary that stores database credentials

    Returns:

    SQL engine
    """

    pw = creds['password']
    special_char = "!@#$%^&*()-+?_=,<>/"
    if any(c in special_char for c in pw):
        password = urlquote(pw)
        engine = create_engine(f'postgresql://{creds["user"]}:{password}@{creds["host"]}:{creds["port"]}/{creds["db"]}')
    else:
        engine = create_engine(f'postgresql://{creds["user"]}:{creds["password"]}@{creds["host"]}:{creds["port"]}/{creds["db"]}')

    return engine
