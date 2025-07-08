
from django.test import TestCase
from .models import Producto

class ProductoTest(TestCase):
    def test_creacion_producto(self):
        producto = Producto.objects.create(nombre="Test", disponible=True, precio=10)
        self.assertEqual(producto.nombre, "Test")
