# Security Policy

## 🔒 Versiones Soportadas

Actualmente estamos dando soporte de seguridad a las siguientes versiones:

| Versión | Soportada          |
| ------- | ------------------ |
| 1.x.x   | :white_check_mark: |
| < 1.0   | :x:                |

## 🐛 Reportar una Vulnerabilidad

La seguridad de L.A.M.A. Medellín es una prioridad. Si descubres una vulnerabilidad de seguridad, agradecemos tu ayuda para divulgarla de manera responsable.

### ¿Cómo reportar?

**Por favor, NO abras un issue público** si encuentras una vulnerabilidad de seguridad.

En su lugar:

1. **Envía un email a**: [security@example.com](mailto:security@example.com)
   - O contacta al mantenedor principal vía mensaje privado de GitHub

2. **Incluye en tu reporte**:
   - Descripción de la vulnerabilidad
   - Pasos para reproducir el problema
   - Versiones afectadas
   - Posible impacto de la vulnerabilidad
   - Sugerencias de solución (si las tienes)

### ¿Qué esperar?

- **Confirmación**: Recibirás una confirmación de recepción en 48 horas
- **Evaluación**: Evaluaremos el reporte y te contactaremos en 5 días hábiles
- **Actualizaciones**: Te mantendremos informado del progreso cada 7 días
- **Resolución**: Trabajaremos para publicar un fix lo antes posible
- **Crédito**: Si lo deseas, te daremos crédito en el CHANGELOG

## 🛡️ Política de Divulgación

- Mantenemos confidencialidad sobre vulnerabilidades reportadas hasta que se publique un fix
- Coordinamos el timing de divulgación pública contigo
- Publicamos avisos de seguridad en la sección de Security Advisories de GitHub

## 🔐 Prácticas de Seguridad Recomendadas

### Para Desarrolladores

- Nunca commitees credenciales, tokens o secretos en el código
- Usa variables de entorno para información sensible
- Mantén las dependencias actualizadas
- Sigue las mejores prácticas de OWASP

### Para Deployment

- Usa HTTPS en todos los ambientes
- Configura CORS apropiadamente
- Implementa rate limiting
- Usa autenticación y autorización robustas
- Mantén logs de seguridad
- Realiza backups regulares de la base de datos

## 📚 Recursos

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [ASP.NET Core Security Best Practices](https://learn.microsoft.com/aspnet/core/security/)
- [React Security Best Practices](https://react.dev/learn/security)

## 🙏 Agradecimientos

Agradecemos a todos los investigadores de seguridad y usuarios que reportan vulnerabilidades de manera responsable.

---

**Última actualización**: Enero 2025
