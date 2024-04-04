import sys
import psycopg2

def fetch_products_by_shelves(order_numbers):
    try:
        connection = psycopg2.connect(
            user="postgres",
            password="148635",
            host="localhost",
            port="5432",
            database="Shelf"
        )
        cursor = connection.cursor()

        query = """
            SELECT s.name AS shelf_name, p.name, p.id, o.order_number, sum(o.quantity) as quantity, ps.primary_shelf, array_agg(psd.shelf_id) as dop_shelf_ids
            FROM shelves s
            JOIN product_shelves ps ON s.id = ps.shelf_id
            JOIN products p ON ps.product_id = p.id
            JOIN orders o ON p.id = o.product_id
            LEFT JOIN product_shelves psd ON p.id = psd.product_id AND psd.primary_shelf = FALSE
            WHERE o.order_number IN %s AND ps.primary_shelf = TRUE
            GROUP BY s.name, p.name, p.id, o.order_number, ps.primary_shelf
            ORDER BY s.name, o.order_number, p.name
        """

        cursor.execute(query, (order_numbers,))
        rows = cursor.fetchall()

        current_shelf = None
        current_order = None
        for row in rows:
            shelf_name, product_name, product_id, order_number, quantity, primary_shelf, dop_shelf_ids = row
            if shelf_name != current_shelf:
                if current_shelf is not None:
                    print("=" * 30)
                print(f"===Стеллаж {shelf_name}")
                current_shelf = shelf_name

            if order_number != current_order:
                if current_order is not None:
                    if dop_shelf_ids:
                        print(f"доп стеллаж: {', '.join(map(str, dop_shelf_ids))}")
                    else:
                        print("доп стеллаж: None")
                    print()
                print(f"заказ {order_number}")
                current_order = order_number

            print(f"{product_name} (id={product_id}) - {quantity} шт")
            dop_shelf_ids = []

        if current_shelf is not None:
            if dop_shelf_ids:
                print(f"доп стеллаж: {', '.join(map(str, dop_shelf_ids))}")
            else:
                print("доп стеллаж: None")

    except (Exception, psycopg2.Error) as error:
        print("Ошибка при выполнении запроса:", error)
    finally:
        if connection:
            cursor.close()
            connection.close()

if __name__ == "__main__":
    if len(sys.argv) > 1:
        order_numbers = tuple(sys.argv[1:])
        fetch_products_by_shelves(order_numbers)
    else:
        print("Введите номера заказов в качестве аргументов командной строки.")
