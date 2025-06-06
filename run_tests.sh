#!/bin/bash

# Script para ejecutar los 4 tests específicos
echo "🧪 Ejecutando los 4 tests específicos de firts_app"
echo "=================================================="

# Colores
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# Contador de tests fallidos
FAILED_TESTS=0

# Función para mostrar resultados
show_result() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✅ $2 - PASÓ${NC}"
    else
        echo -e "${RED}❌ $2 - FALLÓ${NC}"
        FAILED_TESTS=$((FAILED_TESTS + 1))
    fi
    echo ""
}

echo -e "${BLUE}📦 Obteniendo dependencias...${NC}"
flutter pub get
echo ""

echo -e "${BLUE}🧪 Ejecutando los 4 tests específicos...${NC}"
echo ""

# 1. Test de Modelo
echo -e "${BLUE}1️⃣ Test de Modelo - Product Model${NC}"
flutter test test/product_model_simple_test.dart --reporter=expanded
show_result $? "Test de Modelo (Product)"

# 2. Test de Servicio
echo -e "${BLUE}2️⃣ Test de Servicio - Cart Service${NC}"
flutter test test/cart_service_simple_test.dart --reporter=expanded
show_result $? "Test de Servicio (Cart)"

# 3. Test de UI
echo -e "${BLUE}3️⃣ Test de UI - Login Screen${NC}"
flutter test test/login_ui_simple_test.dart --reporter=expanded
show_result $? "Test de UI (Login)"

# 4. Test Unitario
echo -e "${BLUE}4️⃣ Test Unitario - Email Validator${NC}"
flutter test test/email_validator_unit_test.dart --reporter=expanded
show_result $? "Test Unitario (EmailValidator)"

echo "=================================================="
echo -e "${BLUE}📋 RESUMEN${NC}"
echo "=================================================="

if [ $FAILED_TESTS -eq 0 ]; then
    echo -e "${GREEN}🎉 ¡Todos los 4 tests pasaron exitosamente!${NC}"
    echo -e "${GREEN}✨ Tu código está funcionando correctamente${NC}"
else
    echo -e "${RED}❌ $FAILED_TESTS test(s) fallaron${NC}"
    echo -e "${RED}🔧 Revisa los errores arriba${NC}"
fi

echo ""
echo "Tests ejecutados:"
echo "1. ✅ Test de Modelo (Product parsing y creación)"
echo "2. ✅ Test de Servicio (Cart add/remove/total)"
echo "3. ✅ Test de UI (Login elementos e interacciones)" 
echo "4. ✅ Test Unitario (EmailValidator lógica pura)"