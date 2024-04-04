import psycopg2
from psycopg2 import sql

# Функция для подключения к базе данных
def connect_to_database():
    try:
        connection = psycopg2.connect(
            user="postgres",
            password="148635",
            host="localhost",
            port="5432",
            database="Shelf"
        )
        return connection
    except (Exception, psycopg2.Error) as error:
        print("Ошибка при подключении к базе данных:", error)
        return None

# Функция для выполнения запроса и получения данных
def fetch_data(query, connection, params=None):
    try:
        cursor = connection.cursor()
        cursor.execute(query, params)
        data = cursor.fetchall()
        cursor.close()
        return data
    except (Exception, psycopg2.Error) as error:
        print("Ошибка при выполнении запроса:", error)
        return None
#--------------------------------#--------------------------------#--------------------------------
# Функция для вывода информации о товарах и стеллажах для указанных заказов
# def print_products_by_shelves(order_numbers, connection):
#     try:
#         print("=+=+=+=")
#         print("Страница сборки заказов", ",".join(map(str, order_numbers)))
#         print()
#
#         query = sql.SQL("""
#             SELECT s.name AS shelf_name, p.name, p.id, o.order_number, sum(o.quantity) as quantity,
#             bool_or(ps.primary_shelf) AS primary_shelf
#             FROM shelves s
#             JOIN product_shelves ps ON s.id = ps.shelf_id
#             JOIN products p ON ps.product_id = p.id
#             JOIN orders o ON p.id = o.product_id
#             WHERE o.order_number IN %s
#             GROUP BY s.name, p.name, p.id, o.order_number
#             ORDER BY s.name, o.order_number, p.name;
#         """)
#
#         data = fetch_data(query, connection, (tuple(order_numbers),))
#         if data:
#             current_shelf = None
#             for row in data:
#                 shelf_name, product_name, product_id, order_number, quantity, primary_shelf = row
#                 if shelf_name != current_shelf:
#                     print(f"===Стеллаж {shelf_name}")
#                     current_shelf = shelf_name
#                 if primary_shelf :
#                     print('Тут primary_shelf TRUE')
#                     print(f"{product_name} (id={product_id}) - заказ {order_number}, {quantity} шт")
#                 elif not primary_shelf:
#                     print('Тут primary_shelf FALSE')
#                     print('доп стеллаж:')
#                     for i in current_shelf:
#                         print(shelf_name, end=' ')
#
#                     # print(f"{product_name} (id={product_id})")
#                     # print(f"заказ {order_number}, {quantity} шт")
#             print()
#
#         else:
#             print("Нет информации о заказах", ",".join(map(str, order_numbers)))
#         print("=" * 30)
#     except Exception as error:
#         print("Произошла ошибка:", error)


# Функция для вывода информации о товарах и стеллажах для указанных заказов
#--------------------------------#--------------------------------#--------------------------------



def print_products_by_shelves(order_numbers, connection):
    try:
        print("=+=+=+=")
        print("Страница сборки заказов", ",".join(map(str, order_numbers)))
        print()

        query = sql.SQL("""
            SELECT s.name AS shelf_name, p.name, p.id, o.order_number, sum(o.quantity) as quantity, ps.primary_shelf
            FROM shelves s
            JOIN product_shelves ps ON s.id = ps.shelf_id
            JOIN products p ON ps.product_id = p.id
            JOIN orders o ON p.id = o.product_id
            WHERE o.order_number IN %s
            GROUP BY s.name, p.name, p.id, o.order_number, ps.primary_shelf
            ORDER BY s.name, o.order_number, p.name;
        """)

        data = fetch_data(query, connection, (tuple(order_numbers),))
        if data:
            current_shelf = None
            additional_shelves = set()
            for row in data:
                shelf_name, product_name, product_id, order_number, quantity, primary_shelf = row
                if shelf_name != current_shelf:
                    if additional_shelves:
                        print("доп стеллаж:", ",".join(additional_shelves))
                        additional_shelves = set()
                    if product_name or primary_shelf:
                        print(f"===Стеллаж {shelf_name}")
                        current_shelf = shelf_name
                if product_name:
                    if primary_shelf:
                        print(f"{product_name} (id={product_id})")
                        print(f"заказ {order_number}, {quantity} шт")
                    else:
                        additional_shelves.add(shelf_name)
                    if additional_shelves:
                        print("TEST NA DOP STELAG")
                        print('доп стеллаж',additional_shelves)

            if additional_shelves:
                print("доп стеллаж:", ",".join(additional_shelves))
            print()

        else:
            print("Нет информации о заказах", ",".join(map(str, order_numbers)))
        print("=" * 30)
    except Exception as error:
        print("Произошла ошибка:", error)



# Основная функция
def main():
    try:
        # Подключение к базе данных
        connection = connect_to_database()
        if connection:
            # Введите номера заказов, для которых вы хотите получить информацию о товарах
            order_numbers = [10, 11, 14, 15]
            print_products_by_shelves(order_numbers, connection)
            connection.close()
    except Exception as error:
        print("Произошла ошибка:", error)

if __name__ == "__main__":
    main()


